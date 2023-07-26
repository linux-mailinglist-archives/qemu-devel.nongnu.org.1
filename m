Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFA3763B7E
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgIq-00069A-DR; Wed, 26 Jul 2023 11:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOgIX-000689-Fq
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOgIV-00030K-UI
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690384770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HGmXRH01XxdLibv3W8WqCnboTGhf7oNFBgwMl9TghIU=;
 b=QNLm/vVM+9DBY74uiFyKBjbLCjU8y9AaAPzSjoWkOE0hnJ11wONuBXDHbePCTA/eQE847U
 xWTFqY2maMCwExoJpG46lo1Wj6/qy/mlQaNtsAxvlO6+t615sJHBepXzXCNKh2M+4x2fxf
 bT1NOBsDJq+zJaM2+HlRG4x54+aWmdE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-_KSkNW0uME20Yg7eDKErYA-1; Wed, 26 Jul 2023 11:19:29 -0400
X-MC-Unique: _KSkNW0uME20Yg7eDKErYA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63cc3a44aedso20023556d6.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 08:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690384768; x=1690989568;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HGmXRH01XxdLibv3W8WqCnboTGhf7oNFBgwMl9TghIU=;
 b=GlXXP1NuPMlH0DCDdY0zYqzsfE15jeitFI7hiaVm5MSwc+0XECKj8RTQltBdAaCeV6
 6rZIaZVO8SQoICo/B1Mq0soOvY4sMJxhOd9AvaNizNdyL2yy2nN8ldbBOBvCnyH+pK9P
 dPXJIQzYI0RQVBJ+34gp3lRej8Q2SQqMHCi5YACzws5CARod51JBT2SV0pHCTyXfRd4g
 HrF+oNHKE9h2KAYDkzi7Ohq7wn2gqi1cefO3lf9rNsACPMO+iad96ONuZmwmGJrtKaxz
 kqmP/gP9oZWOIqxTydA8h5mv+0YdfK/KqUHEymBApxREgib4xeqsgtrXe0poNxnke0Ca
 hZlQ==
X-Gm-Message-State: ABy/qLbIkv6KYpuMb/qBTUxsEQxh8UDtEACggehVgphN4VUU8ks+tRii
 fpSyJmqF4HlU7NM78fSenWUscMJCNfmNbMnzap4/ndaAxEd9IwjFm8wwS7vZynD+f17xPB8wau9
 IT90ItTHz7yMTCqQ=
X-Received: by 2002:a05:6214:1305:b0:635:da19:a67f with SMTP id
 pn5-20020a056214130500b00635da19a67fmr2612375qvb.1.1690384768569; 
 Wed, 26 Jul 2023 08:19:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFioA22iQYgALqQxGJSkwOO2MiHeTeK9Hea5Ru1L46RFVfpXLLCDfpI5Ym/o5OtiNWLUsk+cA==
X-Received: by 2002:a05:6214:1305:b0:635:da19:a67f with SMTP id
 pn5-20020a056214130500b00635da19a67fmr2612361qvb.1.1690384768359; 
 Wed, 26 Jul 2023 08:19:28 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05620a152400b00767cb046e40sm4421638qkk.94.2023.07.26.08.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 08:19:28 -0700 (PDT)
Date: Wed, 26 Jul 2023 11:19:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Chensheng Dong <chdong@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration: Allow user to specify migration available
 bandwidth
Message-ID: <ZME5c5tkWDhd0k7D@x1n>
References: <20230724170755.1114519-1-peterx@redhat.com>
 <ZL69LTVHhNzEjqGM@redhat.com> <ZL7VZsaFxkIq4+cP@x1n>
 <ZL+TBBtL+RiMrOXJ@redhat.com> <ZL/wTBP/7ZdM9Xd4@x1n>
 <ZL/z1e/VATzZN10E@redhat.com> <ZL/6f7nNLw+iVHYL@x1n>
 <ZMAB+tI9kIid0kBI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMAB+tI9kIid0kBI@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 25, 2023 at 06:10:18PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 25, 2023 at 12:38:23PM -0400, Peter Xu wrote:
> > I see you used "convergance" explicitly even after PeterM's reply, is that
> > what you prefer over "convergence"?  I do see more occurances of
> > "convergence" as a word in migration context, though.
> 
> Ignore my speling erors :-)

Ohh, so that's not intended. :) Actually there's indeed the word
"convergance" which can be applied here, but since I'm not native I really
can't figure out the fact even with a dictionary.

> 
> >                                                       Any better name you
> > can come up with, before I just go with "max-convergence-bandwidth" (I
> > really cannot come up with anything better than this or available-bandwidth
> > for now)?
> 
> Anothre idea could be 'max-switchover-bandwidth'  ?

Yeah, switchover can also be called a phase of migration, so in parallel of
existing precopy/postcopy, sounds like a good one.  I'll respin with that
if no further suggestions.  Thanks.

-- 
Peter Xu


