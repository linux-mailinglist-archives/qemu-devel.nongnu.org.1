Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53733707E19
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzarV-0006VU-No; Thu, 18 May 2023 06:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzarU-0006V7-G9
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzarT-0006wI-2M
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLu4HZbT4PZX2T4Ge9tZdZ5EID3HoNGy/Z3Zf9AYmp8=;
 b=O//0pS9DhaepyTungwySN0lkSdQ6iwjN3/5n0rA/sx1PNd8t6R0ZMWwXeUMKXtyt2Y0ICt
 BFudgHdzebn8fE4NNtntmGAsFHiZYJbsWyW6d7o2NprmwXm5MOX/HQ2/FyjB0AxNz7+IG3
 rQMICaivhAMvLbfdQvGcSj8cLQs8XFY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-NPGSW1pyPMGSXBcjTcoDng-1; Thu, 18 May 2023 06:27:52 -0400
X-MC-Unique: NPGSW1pyPMGSXBcjTcoDng-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f4245ffb03so11646685e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405671; x=1686997671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLu4HZbT4PZX2T4Ge9tZdZ5EID3HoNGy/Z3Zf9AYmp8=;
 b=DIUQnVIArmKBTWYNqsZulbjjnqtQxeHn8d+oCe+hdTC886JV7W9kOjVOFOSyvVP+A4
 UtNbIDK55InUd9A5FzDHgshDrdScqjBvf2QB76jkN6pZF6AWJ9sxewzh/8YGNLE0AmQd
 uAWLbuOdglcgG/r4ws+GRceMKdBOxqUVCDWQfOht3XIuos4JU4mCi3mZrWQcfBCx3HOL
 0iGDHrXNhEho/LGfey4fsNoPPRifB4nizlE0E6v7LsTCW3V4ZVlX+Jp3YitCKPE2Vpe6
 0jYjyvXSYD/Loa09FlFIKa97i+wg2dBxr5MjL76hMc3Y3YYDUur1GGNda5tiPo6coxoV
 RigQ==
X-Gm-Message-State: AC+VfDyqwB8JnU6nH3KOc4jhd0xthtoOeT9j4UOd2XEidHHk7jT6a7M/
 3inBjIhV/ErhTvTGmKWQR5m5tSL2T6cwOzLpBKhwmWRQyQfLcSxXH9UGsfb9sOzL3YuTz7aYkMM
 AGJoYN89TaxYgKkgl2QXCWNE=
X-Received: by 2002:a05:600c:2143:b0:3f5:60b:31 with SMTP id
 v3-20020a05600c214300b003f5060b0031mr1010341wml.27.1684405671074; 
 Thu, 18 May 2023 03:27:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VjT/bGBavxQiC9fo9D9V4wMVtBWpSJ1ZHgRkeU9xWIwOeZlGIqi6G/AUJvBBt51Tm1cdllQ==
X-Received: by 2002:a05:600c:2143:b0:3f5:60b:31 with SMTP id
 v3-20020a05600c214300b003f5060b0031mr1010333wml.27.1684405670732; 
 Thu, 18 May 2023 03:27:50 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 h2-20020a1ccc02000000b003f421979398sm4850777wmb.26.2023.05.18.03.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:27:50 -0700 (PDT)
Date: Thu, 18 May 2023 06:27:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
Message-ID: <20230518061346-mutt-send-email-mst@kernel.org>
References: <20230517120751.14679-1-anisinha@redhat.com>
 <B4E3F951-D046-428B-BA6D-57D5DBCDFED6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B4E3F951-D046-428B-BA6D-57D5DBCDFED6@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, May 17, 2023 at 04:43:53PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 17. Mai 2023 12:07:51 UTC schrieb Ani Sinha <anisinha@redhat.com>:
> >Currently the meson based QEMU build process locates the iasl binary from the
> >current PATH and other locations [1] and uses that to set CONFIG_IASL which is
> >then used by the test.
> >
> >This has two disadvantages:
> > - If iasl was not previously installed in the PATH, one has to install iasl
> >   and rebuild QEMU in order to pick up the iasl location. One cannot simply
> >   use the existing bios-tables-test binary because CONFIG_IASL is only set
> >   during the QEMU build time by meson and then bios-tables-test has to be
> >   rebuilt with CONFIG_IASL set in order to use iasl.
> > - Sometimes, the stock iasl that comes with distributions is simply not good
> >   enough because it does not support the latest ACPI changes - newly
> >   introduced tables or new table attributes etc. In order to test ACPI code
> >   in QEMU, one has to clone the latest acpica upstream repository and
> >   rebuild iasl in order to get support for it. In those cases, one may want
> >   the test to use the iasl binary from a non-standard location.
> >
> >In order to overcome the above two disadvantages, we introduce a new
> >environment variable IASL_PATH that can be set by the tester pointing to an
> >possibly non-standard iasl binary location.
> 
> Why not add a submodule -- like we do with dtc -- and use that? Then
> we could possibly convert the ACPI blobs used in bios-tables-test into
> text files which would make AML patches a bit more comprehensible. We
> also didn't have to trust the commit messages to contain the actual
> change because one would see it right in the patch.
> 
> Best regards,
> Bernhard

Yea people dislike submodules but I guess we could come up
with something. I stumbled upon git-subrepo recently
but did not try it yet.

There's a long list of issues unrelated to having iasl installed though:
- IASL disassembler output is unstable, tends to change
  with each revision
- IASL disassembler lacks (or used to, last time I looked)
  support for all hosts that QEMU wants to support
  (e.g. I think it is still somewhat broken on BE)
- Tends to crash in weird ways on unexected ACPI

I talked to ACPICA guys about guarateed output with some flag
and they were uninterested.
We used to have expected ASL in git, was a little easier for
contributors but a pain for maintainers and users.

-- 
MST


