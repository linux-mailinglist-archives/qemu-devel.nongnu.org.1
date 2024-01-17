Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7783016B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:41:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ1Tt-0007xq-5u; Wed, 17 Jan 2024 03:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rQ1To-0007xK-Fo
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:41:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rQ1Tm-00014z-2G
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705480857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbexiVYUa4f5Ut9Oc53ij44ge22AhxP47f1RuO8L+B4=;
 b=KUQzv79itMYQ61UP4ZTgOq6p3x42lSbuY4W0rdHfgiSyvwTduR1dVed7NGf15W8rmhQ/1V
 DyfBIhSjteJ92JimjpBN4KfbLAAaERFqSJMCUTkV/GcgRtuYEcO4/PxZS4e/mRsmQU+96V
 4HtCEDIz/jJA17C6Ide9BAi1B9/Wj9o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-7430d1oHPm-4dmNNbOYrxw-1; Wed, 17 Jan 2024 03:40:54 -0500
X-MC-Unique: 7430d1oHPm-4dmNNbOYrxw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e53200380so61239415e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705480853; x=1706085653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FbexiVYUa4f5Ut9Oc53ij44ge22AhxP47f1RuO8L+B4=;
 b=vS4umAHBzBKSnXoab5g0qjmAMVJXiUgvgGOa1YbPA+kJCchoJxFA422aAKLEeOHQ54
 FuwxDC9K3OybjNcVo8a+C8JbbZhs4ZIZHZv0zyeIcqh3+6tKrrvU3QvbF9WSsoeRga5t
 B/jI8nGSRWCaInWerxoyGyhqtY3RvgCTVOojobMrIojaoQYXA/CYLRPhLDCoxBmrcsQt
 ESUresVfGK+ZvoI/9SQwyPqVgArYv5nzGH86N59t1C43G6n7JY8RDattBD0oBDbQ9Q8Z
 GyRrexPuyiTt06y+aNETWlLFRDfKhHRdz0AhSQNCLrdwVU5zT87OgVtfD2aTXrzaxb8N
 JZdg==
X-Gm-Message-State: AOJu0YzvJCoMXN+5gmOuE9Iu9gBcRYjzpzo3x9570JjtcQMFBmW4BQwK
 fkRHoIC7SmOn+50jKMJpVIL4x1uT2xl7IKukD1e1eZaDNy2gYNYZEi16le3Tf30pmDjRHB0TrBy
 3z8iF9x3Zq+PJ2imYylbPb+8=
X-Received: by 2002:a1c:6a03:0:b0:40e:6948:3226 with SMTP id
 f3-20020a1c6a03000000b0040e69483226mr3655426wmc.134.1705480853238; 
 Wed, 17 Jan 2024 00:40:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPYAZW+AI3wgca/eP1Gqb+Jk+G9cN9Xpp1wWnRR3NwSOBPsNycUxhKVxq7zz6wWxNML65eOA==
X-Received: by 2002:a1c:6a03:0:b0:40e:6948:3226 with SMTP id
 f3-20020a1c6a03000000b0040e69483226mr3655421wmc.134.1705480852957; 
 Wed, 17 Jan 2024 00:40:52 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c35c700b0040d1bd0e716sm21834056wmq.9.2024.01.17.00.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 00:40:52 -0800 (PST)
Date: Wed, 17 Jan 2024 09:40:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Felix Wu <flwu@google.com>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] SMBIOS type 8 should use T8_BASE.
Message-ID: <20240117094051.401b6316@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240117093847.5dc92824@imammedo.users.ipa.redhat.com>
References: <20240111192522.2795498-1-flwu@google.com>
 <20240111192522.2795498-2-flwu@google.com>
 <20240117093847.5dc92824@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 17 Jan 2024 09:38:47 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 11 Jan 2024 19:25:22 +0000
> Felix Wu <flwu@google.com> wrote:
> 
> it is missing Signed-off tag a minimum, and also commit message should describe in more detail
> what's wrong and what's breaks and how it's being fixed with references to spec preferably. 
> 
> please see https://www.qemu.org/docs/master/devel/submitting-a-patch.html
> for requirements to commit message of the patch.
>

on top of that pls consider adding test case for it in
tests/qtest/bios-tables-test.c

> > ---
> >  hw/smbios/smbios.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index 2a90601ac5..7dda84b284 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -591,6 +591,7 @@ bool smbios_skip_table(uint8_t type, bool required_table)
> >  #define T2_BASE 0x200
> >  #define T3_BASE 0x300
> >  #define T4_BASE 0x400
> > +#define T8_BASE 0x800
> >  #define T11_BASE 0xe00
> >  
> >  #define T16_BASE 0x1000
> > @@ -775,7 +776,7 @@ static void smbios_build_type_8_table(void)
> >      struct type8_instance *t8;
> >  
> >      QTAILQ_FOREACH(t8, &type8, next) {
> > -        SMBIOS_BUILD_TABLE_PRE(8, T0_BASE + instance, true);
> > +        SMBIOS_BUILD_TABLE_PRE(8, T8_BASE + instance, true);  
> 
> we can't do that unconditionally as it will break live migration
> where firmware reading this might get part of broken tables (on source host)
> and 2nd part of fixed ones (from target host).
> 
> So we need to use T0_base for old machine types and T8_BASE for
> default/new machine types.
> for example see how 'pcmc->smbios_uuid_encoded' is used.
> unless it's x86 specific, this should be done for affected machine types.
>   
> >          SMBIOS_TABLE_SET_STR(8, internal_reference_str, t8->internal_reference);
> >          SMBIOS_TABLE_SET_STR(8, external_reference_str, t8->external_reference);  
> 


