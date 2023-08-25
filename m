Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06930789009
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 22:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZdsW-0001f6-K2; Fri, 25 Aug 2023 16:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZdsR-0001ex-QP
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 16:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZdsP-0007HI-F8
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 16:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692997072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MyZZXklZkFxU14BW7xU7GCiFgIeey+wQHKmWGfF1rPw=;
 b=M3l6dgALd7FJ0G/ypVS2GxiSAXbA618LpipGlPXeXQvaNh7KMTB8Reoqv0DuK29te5jwQM
 Nlqutp/ZBUhMIiYbHmar373X00P1CYx/vhSQdq+I6UPzp9PulJd5TWVm2weH2+Hyuh708N
 vUVsr4snV8JeuOMP2e1IaCbdGEOcSZ0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-F3oh-DatMfyG5GLvPjCi0A-1; Fri, 25 Aug 2023 16:57:50 -0400
X-MC-Unique: F3oh-DatMfyG5GLvPjCi0A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-64a4269ca98so3333686d6.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 13:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692997070; x=1693601870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyZZXklZkFxU14BW7xU7GCiFgIeey+wQHKmWGfF1rPw=;
 b=VoxJlzB7jE2+WVslivuBlrizJlFUIUyE09lCg21SDd9k1cJ9n4O4lAUYx7v+dsglfP
 5r5QNzclK/foS/NhkHYRyjaSzOCmJtrEf28tVkPdxzf3aC5cN3ea4Pk48IwmxBd1tVCo
 eLXORpwWAT68m2s5OR9t8YbKt8Jq/p75xX14/lroWtFWmtjthgwfezMG6DH4UEvtWm0Q
 N6qahxQ5RQrUm176w98hzkbxqGXS5EBAf0APTo53FaKyYeMAu43Nf1K10TgA6Zk73jce
 PbrnTgx6rm2fo8ue+mRSfdDanG3TwA8T269xwmLoyD/CixF39TACeq0JNH2DVAqjvr5w
 2mjQ==
X-Gm-Message-State: AOJu0Yya1YQAFSBV3gnLpuNhguiet8xsZ47bJWm2IPwvNRlWTC0bSqle
 fHdtIAbN0wVhnRYz78rvS5yMVPHx+SEsZvVuD9r71upGDV686FVlhqR8SGucgS/3g77+qvq114g
 nWIJDxlIWV0zGnig=
X-Received: by 2002:a05:6214:4111:b0:63f:89d3:bef6 with SMTP id
 kc17-20020a056214411100b0063f89d3bef6mr22646971qvb.6.1692997070414; 
 Fri, 25 Aug 2023 13:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb/wn2kHZE6DZdm41/8rpQoiunPix3tRFGnExbGC9zPzwzlyY5eLcVymo40fzSoJOp5OftXA==
X-Received: by 2002:a05:6214:4111:b0:63f:89d3:bef6 with SMTP id
 kc17-20020a056214411100b0063f89d3bef6mr22646954qvb.6.1692997070067; 
 Fri, 25 Aug 2023 13:57:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z10-20020a0cf00a000000b0064c107c9679sm792271qvk.125.2023.08.25.13.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 13:57:49 -0700 (PDT)
Date: Fri, 25 Aug 2023 16:57:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/4] tests/migration-test: Add a test for null
 parameter setups
Message-ID: <ZOkVzPl+ra1ST7yd@x1n>
References: <20230825171517.1215317-1-peterx@redhat.com>
 <20230825171517.1215317-3-peterx@redhat.com>
 <4c58d125-3d98-af27-2833-95913dc52df9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c58d125-3d98-af27-2833-95913dc52df9@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 25, 2023 at 07:33:23PM +0200, Thomas Huth wrote:
> On 25/08/2023 19.15, Peter Xu wrote:
> > Add a test for StrOrNull parameters (tls-*).
> > 
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   tests/qtest/migration-test.c | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index 62d3f37021..64efee8b04 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -1471,6 +1471,26 @@ static void test_postcopy_preempt_all(void)
> >   #endif
> > +/*
> > + * We have a few parameters that allows null as input, test them to make
> > + * sure they won't crash (where some used to).
> > + */
> > +static void test_null_parameters(void)
> > +{
> > +    const char *allow_null_params[] = {
> > +        "tls-authz", "tls-hostname", "tls-creds"};
> 
> I'd place the ending bracket on a new line.
> 
> > +    QTestState *vm = qtest_init("");
> > +    int i;
> > +
> > +    for (i = 0; i < sizeof(allow_null_params) / sizeof(const char *); i++) {
> 
> Could you use ARRAY_SIZE() instead of calculating it on your own?

Sure (on both), thanks.

-- 
Peter Xu


