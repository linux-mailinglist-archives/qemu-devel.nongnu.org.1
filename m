Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33CAE7756
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Jun 2025 08:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUJqc-0007UG-Ny; Wed, 25 Jun 2025 02:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUJqa-0007U2-Lu
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 02:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uUJqX-0007rw-1S
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 02:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750833776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=znHqPturVhMIxOxVkX3Ul+160SFzYRD/LZSMtM9Llq4=;
 b=FGDXDbU1fxEhDgkBo+0aTjGzXg3Tf5w7V63MQkSeC5RpNA31xDR807WK/LxvCcNtm+e89b
 S16N2UN8wx/pH/jTug3yqvJhEP7FbIhIETJH9qMrw6a5BSLNaF3iZ2DYsDGsul6/XE1HBv
 r2TWwnfUBczRjVcAGuw60ocMw4xE/6I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-6oYJU7HYOXiGWt-lFgp5wQ-1; Wed,
 25 Jun 2025 02:42:52 -0400
X-MC-Unique: 6oYJU7HYOXiGWt-lFgp5wQ-1
X-Mimecast-MFC-AGG-ID: 6oYJU7HYOXiGWt-lFgp5wQ_1750833771
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F46218089B4; Wed, 25 Jun 2025 06:42:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5C4E195608F; Wed, 25 Jun 2025 06:42:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 036C421E6A27; Wed, 25 Jun 2025 08:42:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan Weil <sw@weilnetz.de>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Jason Wang <jasowang@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
In-Reply-To: <957e1b39-bb40-4752-9d61-84f2b1ca7aa2@redhat.com> (Laurent
 Vivier's message of "Tue, 24 Jun 2025 10:37:12 +0200")
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com>
 <87pletlflp.fsf@pond.sub.org>
 <957e1b39-bb40-4752-9d61-84f2b1ca7aa2@redhat.com>
Date: Wed, 25 Jun 2025 08:42:47 +0200
Message-ID: <87bjqccoew.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Laurent Vivier <lvivier@redhat.com> writes:

> On 24/06/2025 10:16, Markus Armbruster wrote:
>> Laurent Vivier <lvivier@redhat.com> writes:
>> 
>>> This commit introduces support for passt as a new network backend.
>>> passt is an unprivileged, user-mode networking solution that provides
>>> connectivity for virtual machines by launching an external helper process.
>>>
>>> The implementation reuses the generic stream data handling logic. It
>>> launches the passt binary using GSubprocess, passing it a file
>>> descriptor from a socketpair() for communication. QEMU connects to
>>> the other end of the socket pair to establish the network data stream.
>>>
>>> The PID of the passt daemon is tracked via a temporary file to
>>> ensure it is terminated when QEMU exits.
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> 
>> [...]
>> 
>>> diff --git a/qapi/net.json b/qapi/net.json
>>> index 97ea1839813b..76d7654414f7 100644
>>> --- a/qapi/net.json
>>> +++ b/qapi/net.json
>>> @@ -112,6 +112,125 @@
>>>     'data': {
>>>       'str': 'str' } }
>>>   
>>> +##
>>> +# @NetDevPasstOptions:
>>> +#
>>> +# Unprivileged user-mode network connectivity using passt
>>> +#
>>> +# @path: path to passt binary
>> 
>> I'd prefer a more descriptive name.
>> 
>> Elsewhere in this file, we refer to programs like this:
>> 
>>     # @script: script to initialize the interface
>>     #
>>     # @downscript: script to shut down the interface
>> 
>> passt isn't a script, of course.
>> 
>> I don't know, perhaps
>> 
>>     # @passt-filename: the passt program to run.
>> 
>> or even
>> 
>>     # @passt: Filename of the passt program to run.

Uh, I missed that @path is optional.  What's the default?  It needs to
be documented.

>>> +#
>>> +# @quiet: don't print informational messages
>> 
>> What does the printing?  A peek at the code I snipped suggests this flag
>> is passed to the passt binary as --quiet.  Correct?
>> 
>>> +#
>>> +# @debug: be verbose
>>> +#
>>> +# @trace: extra verbose
>> 
>> Likewise for these two.
>> 
>>> +#
>>> +# @vhost-user: enable vhost-user

[...]

>>> +# @udp-ports: UDP ports to forward
>> 
>> Is there anything in this struct that configures qemu-system-FOO itself,
>> i.e. isn't just passed to passt?
>> 
>
> Yes, all parameters are just passed to passt.

They're all optional.  Default values / behavior need to be documented.
I figure we pass them to passt only when present.  This means behavior
when absent is whatever passt does then.

> Do you think it's better not to add all these parameters to netdev backend but only one 
> generic containing the passt command line parameters?
>
> Thanks,
> Laurent


