Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD2749104
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 00:36:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHB5E-0003Oh-3g; Wed, 05 Jul 2023 18:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHB5B-0003OU-Hm
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHB57-0000Fm-Gq
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688596478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3xqgAHqi6LJEpn1LonfZqKjNFsL5NxAXsBaclqxssA=;
 b=ELnMFWz6SggNOT8iAWq8A8jqIslOAvuDuLIAc61kXuzBP89GbJYq1NaI36CeFBKgiqPbR7
 ppKj/KOZ9RUGVSAL4tBKTUEqUauvg946iNFQp72ibks9ya3xDs5AQ/9CnRyrTUTooL8uJS
 j5TsFLCl4iq66Ayguc2l5gV9Kw27yF8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-Ykl1MnHMOcqlB1Oe2a1d2g-1; Wed, 05 Jul 2023 18:34:37 -0400
X-MC-Unique: Ykl1MnHMOcqlB1Oe2a1d2g-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76721ad9ed7so1221585a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 15:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688596477; x=1691188477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3xqgAHqi6LJEpn1LonfZqKjNFsL5NxAXsBaclqxssA=;
 b=VTUm9DrEHLEiPmFXRsRHCgd6BH252JQ0gKygyqDEXMdYUAFNuF+klZffB7iQCcXjv+
 rpIyGB5/eb3rHBC1xy8rK3m2yoePrSnQw483IAilgduAAIjVythszaNW7NzCgty+sIkF
 FrLIgR5RR6B2w9iZZ2CKTAis4PW7mhMFfAbSNY5pzZLOzb4v1qqYNPQ/yWlZR4yBpLSG
 coOnsIQTRFU2M+abHosNnTjAv+MDLDHbS/8kgBHqP3bEkkXdQAiwNobKY9m0ypWOFgTi
 Xm5jAaU9l808ggQD5rHn1zi9IjKoEFFXfBQH4ppxNa2UMTAlPZFctA7iROsZfir1WygS
 JTrg==
X-Gm-Message-State: ABy/qLaP0r3YZ7Z87CJ995U/xS5DpYjpfjXOJFTrhO9rxaZs9tT4KBr6
 wCg3sMYe8j4rb7Pi9+fzHKyoN8f7T7hsf4ddhm3PSpm0/+NICOui3EKisGFsdhXa+kkvnkCEuWQ
 vqESfFS49Mup3XZA=
X-Received: by 2002:a05:620a:4510:b0:762:41d6:c3dc with SMTP id
 t16-20020a05620a451000b0076241d6c3dcmr203313qkp.0.1688596477018; 
 Wed, 05 Jul 2023 15:34:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjpfof7Et/aww0SefCAc5CTVkPCzCPl5sWv6z1NwfAkKknQkzoNljTWL2NtUE2TG8Aj6wcHw==
X-Received: by 2002:a05:620a:4510:b0:762:41d6:c3dc with SMTP id
 t16-20020a05620a451000b0076241d6c3dcmr203303qkp.0.1688596476776; 
 Wed, 05 Jul 2023 15:34:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x18-20020a05620a01f200b0075cc5e34e48sm96913qkn.131.2023.07.05.15.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 15:34:36 -0700 (PDT)
Date: Wed, 5 Jul 2023 18:34:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 7/7] migration: Provide explicit error message for
 file shutdowns
Message-ID: <ZKXv+1eoDDlWj812@x1n>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-8-peterx@redhat.com>
 <878rbu3tgm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878rbu3tgm.fsf@suse.de>
Received-SPF: permerror client-ip=216.145.221.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_FAIL=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jul 05, 2023 at 07:05:13PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Provide an explicit reason for qemu_file_shutdown()s, which can be
> > displayed in query-migrate when used.
> >
> 
> Can we consider this to cover the TODO:
> 
>  * TODO: convert to propagate Error objects instead of squashing
>  * to a fixed errno value
> 
> or would that need something fancier?

The TODO seems to say we want to allow qemu_file_shutdown() to report an
Error* when anything wrong happened (e.g. shutdown() failed)?  While this
patch was trying to store a specific error string so when query migration
later it'll show up to the user.  If so, IMHO they're two things.

> 
> > This will make e.g. migrate-pause to display explicit error descriptions,
> > from:
> >
> > "error-desc": "Channel error: Input/output error"
> >
> > To:
> >
> > "error-desc": "Channel is explicitly shutdown by the user"
> >
> > in query-migrate.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/qemu-file.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > index 419b4092e7..ff605027de 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -87,7 +87,10 @@ int qemu_file_shutdown(QEMUFile *f)
> >       *      --> guest crash!
> >       */
> >      if (!f->last_error) {
> > -        qemu_file_set_error(f, -EIO);
> > +        Error *err = NULL;
> > +
> > +        error_setg(&err, "Channel is explicitly shutdown by the user");
> 
> It is good that we can grep this message. However, I'm confused about
> who the "user" is meant to be here and how are they implicated in this
> error.

Ah, here the user is who sends the "migrate-pause" command, according to
the example of the commit message.

What I wanted to do is provide a clear message (besides -EIO) when
query-migrate, so we know more on how the migration is paused/stopped/...
Before that it shows that the same as e.g. any form of IO errors happened.

Thanks,

-- 
Peter Xu


