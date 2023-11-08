Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE07E5018
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 06:39:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0bI1-0006J8-Hl; Wed, 08 Nov 2023 00:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0bHy-0006HY-41
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0bHv-0004nj-I9
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699421978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSoktAXdI3gDkzgjmNFcexpR5i8uKXxKOOvcL6xRp5M=;
 b=Us1XhnvKCsz8xndKpHIj/NH2/Ake0okyZ2SRQG0oJuJ4J+zedNpAaAHSgC0xHscJaGIGft
 MCFgHSihsCGuiRu6c9dhSzITZydaFRUWNmLPCcOma0UdXWG5h4X7rSZuuEGVX80j9eZqxk
 B+B5ODsCh9s1snmSTsAdYd8MIJ0UMrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-dfPd0ji8P1KgXY9JJbDHhg-1; Wed, 08 Nov 2023 00:39:36 -0500
X-MC-Unique: dfPd0ji8P1KgXY9JJbDHhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C906285A58B;
 Wed,  8 Nov 2023 05:39:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 907792026D68;
 Wed,  8 Nov 2023 05:39:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82FD521E6A1F; Wed,  8 Nov 2023 06:39:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: marcandre.lureau@redhat.com,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  richard.henderson@linaro.org,
 Beraldo Leal <bleal@redhat.com>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Re: [PULL 3/8] dump: Add command interface for kdump-raw formats
References: <20231103070136.437557-1-marcandre.lureau@redhat.com>
 <20231103070136.437557-4-marcandre.lureau@redhat.com>
 <CAFEAcA9Pzr_bHom6hy8g8ARS6kbaqLZ8i0wCFT_yjrvBfJu9tQ@mail.gmail.com>
Date: Wed, 08 Nov 2023 06:39:34 +0100
In-Reply-To: <CAFEAcA9Pzr_bHom6hy8g8ARS6kbaqLZ8i0wCFT_yjrvBfJu9tQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 7 Nov 2023 13:54:08 +0000")
Message-ID: <874jhwerc9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 3 Nov 2023 at 07:02, <marcandre.lureau@redhat.com> wrote:
>>
>> From: Stephen Brennan <stephen.s.brennan@oracle.com>
>>
>> The QMP dump API represents the dump format as an enumeration. Add three
>> new enumerators, one for each supported kdump compression, each named
>> "kdump-raw-*".
>>
>> For the HMP command line, rather than adding a new flag corresponding to
>> each format, it seems more human-friendly to add a single flag "-R" to
>> switch the kdump formats to "raw" mode. The choice of "-R" also
>> correlates nicely to the "makedumpfile -R" option, which would serve to
>> reassemble a flattened vmcore.
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> [ Marc-Andr=C3=A9: replace loff_t with off_t, indent fixes ]
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Message-Id: <20230918233233.1431858-4-stephen.s.brennan@oracle.com>
>
> Hi; Coverity points out some issues in this commit:

Proposed fixes:

    Subject: [PATCH 0/2] dump: Fix issues flagged by Coverity
    Message-ID: <20231108053731.112043-1-armbru@redhat.com>


