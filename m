Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8060BD2D88
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 13:49:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8H2E-0003iv-Bu; Mon, 13 Oct 2025 07:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8H2A-0003iB-AB
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8H27-0000FD-8U
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760356083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oS8Fh2Uxi3cdUR6Wq3tTEo6LxZmT1Z2jNBWOdZCCKmg=;
 b=IWaBWno2qKsVcEgFA0n13qHFL+1nH2WT1Lk3HPrY155+6XL6mroB0MiFv0yvfEqshBjySG
 nVMaVqkXX8Nvn46V71wm+IBAkjN2WAc0uxDpDOuznliOQ+duYQQuApyB2LocUbmQg/KSIE
 kxhy9v7jgLlxzRZIJjCHHhLLpb7yZ4g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-zADJxBm5MKmkX6ToNz2uGw-1; Mon,
 13 Oct 2025 07:48:00 -0400
X-MC-Unique: zADJxBm5MKmkX6ToNz2uGw-1
X-Mimecast-MFC-AGG-ID: zADJxBm5MKmkX6ToNz2uGw_1760356078
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9A0E1800357; Mon, 13 Oct 2025 11:47:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C23491800447; Mon, 13 Oct 2025 11:47:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 85EAC18000B2; Mon, 13 Oct 2025 13:47:54 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:47:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <ckxxhhdknnf72lmpxluxog5ti6krojoc2l4dx7ilvssx54vfd2@rv7g7jbahbnf>
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <87ecrbj85s.fsf@pond.sub.org>
 <3flcrys75wbso64zpfbika46klfbg7khbrtug3avrpfixaxmo5@vuidk7ktxnpi>
 <87bjmb6q0c.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjmb6q0c.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> >> > +# @log: Firmware debug log, in base64 encoding.
> >> 
> >> Can this have a partial line at the beginning and/or the end?
> >
> > Yes.
> 
> Partial lines can be troublesome, in particular when complete lines
> start with a prefix in a known format.  If avoiding them isn't
> practical, we should at least document.

The edk2 log has no structured format.  I see this mainly as
trouble-shooting feature, where humans look at the output to diagnose
problems.  I do not expect anyone parsing this automatically.

> >> > +{ 'struct': 'FirmwareLog',
> >> > +  'data': { '*version': 'str',
> >> > +            '*log': 'str' } }
> >> 
> >> These aren't actually optional with the current code.  See [**] above.
> >> I guess you make them optional just in case some other firmware can
> >> provide only one of them.
> >
> > We could also make both mandatory.  There is always the option to return
> > an empty string ...
> 
> Yes.  Loses the distinction between "firmware doesn't support this" and
> "firmware supports this, but it happens to be empty right now".  Do we
> care?

See above, I don't think it matters much.

take care,
  Gerd


