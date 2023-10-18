Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B511A7CE52E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 19:44:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtAaj-0003ZS-5M; Wed, 18 Oct 2023 13:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtAad-0003Uh-Dd
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 13:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtAac-0002vJ-0l
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 13:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697651053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KRUgkUzUTvGXo3F//RmC8qVkPMwQ8sRFx3Jv66zGyA=;
 b=G7vngQlH2Ck2q+IQlFbR1zTqgjAgtUrQMxskRhj1b6quN0eEQUp0QY7fOdOnaBEgwm1D3z
 vdtvkZHOlyIJfTSr/H/O9BMwKm4FulsBbNV3Uj7UNj6ko6s0/0KXOG6cf1Hayk3Jp2l33O
 XPhKK6qeQ5EM5tUu9jPfskfxTIibFWk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-CwagtiZCMTWve-eizY0efQ-1; Wed, 18 Oct 2023 13:44:09 -0400
X-MC-Unique: CwagtiZCMTWve-eizY0efQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-407da05ee50so13226585e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 10:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697651048; x=1698255848;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2KRUgkUzUTvGXo3F//RmC8qVkPMwQ8sRFx3Jv66zGyA=;
 b=aGlpRHQPnOILE5IjoLPtxZb4RoXIraYfCE7HG5e07gS1so+1hT0iJ1G+2iYCsAHgCn
 3vU0r2GWepca/E0a1fieeSADucVtaxGg/1DArtBaQ7Ud50cOAq4SrByxGE0Bp8uMG3cL
 wma4C2pcj2nUkOmAr5GxbyVmmti0W/SLf0v+z2Hk/aFLdKZzu6XGAqUhe3ISqv0N0Kr3
 dyO0oGrc183F1i44cXsiZh3/NVnPMaAC4OVN1mkIZtu+NVyq1GBuLmdl1IkRS3Rgp3P1
 /QeCrvFjtzNMgmHsRKjy0A2Q9vCX6K5xfV9FeYRMMxCpcL12QCjtCf3Dv2WvWFJg1Qw4
 Rpvg==
X-Gm-Message-State: AOJu0YxJBZkfGmS3TMoi+0pdtmFegutbhbjWqG8mjR0YzbZyD+wySMRK
 qJ+uyRRDAMZldTgc8IpDVaFoQNlvAj9/P+ujZyVwa5lGXDyw7ImaUDp4ccFVVUWQcJN732QmT2L
 s/XaQ59OaT44K7As=
X-Received: by 2002:a05:600c:35c4:b0:406:c6de:2bea with SMTP id
 r4-20020a05600c35c400b00406c6de2beamr51458wmq.17.1697651048694; 
 Wed, 18 Oct 2023 10:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvQZrZsLqsFsxJ+/etBT2xkmGz/p09Oqyyqefe8rEPka1QRr7SulsKWxHNuoQmXc/h4A6i8w==
X-Received: by 2002:a05:600c:35c4:b0:406:c6de:2bea with SMTP id
 r4-20020a05600c35c400b00406c6de2beamr51436wmq.17.1697651048323; 
 Wed, 18 Oct 2023 10:44:08 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c15d500b003fee8793911sm2214542wmf.44.2023.10.18.10.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 10:44:06 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:44:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH] cpu/cpuid: check CPUID_PAE to determine 36 bit processor
 address space
Message-ID: <20231018134023-mutt-send-email-mst@kernel.org>
References: <20230912120650.371781-1-anisinha@redhat.com>
 <20231018080451-mutt-send-email-mst@kernel.org>
 <CAK3XEhP-AHh0P12O8=Guia4nVPx1DZjXekYUgoDQ4RKcM4cAfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3XEhP-AHh0P12O8=Guia4nVPx1DZjXekYUgoDQ4RKcM4cAfQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Oct 18, 2023 at 11:08:11PM +0530, Ani Sinha wrote:
> 
> 
> On Wed, 18 Oct, 2023, 5:35 pm Michael S. Tsirkin, <mst@redhat.com> wrote:
> 
>     On Tue, Sep 12, 2023 at 05:36:50PM +0530, Ani Sinha wrote:
>     > PAE mode in x86 supports 36 bit address space. Check the PAE CPUID on the
>     > guest processor and set phys_bits to 36 if PAE feature is set. This is in
>     > addition to checking the presence of PSE36 CPUID feature for setting 36
>     bit
>     > phys_bits.
>     >
>     > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> 
>     Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
>     who's applying this?
> 
> 
> I thought it would be you? What did I miss?

I just don't play a lot with CPUID flags and might easily miss things.
Used to be Eduardo .. maybe CC him.

> 
> 
>     > ---
>     >  target/i386/cpu.c | 2 +-
>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>     >
>     > Note: Not sure what tests I should be running in order to make sure I am
>     > not breaking any guest OSes. Usual qtests pass.
>     >
>     > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>     > index 24ee67b42d..f3a5c99117 100644
>     > --- a/target/i386/cpu.c
>     > +++ b/target/i386/cpu.c
>     > @@ -7375,7 +7375,7 @@ static void x86_cpu_realizefn(DeviceState *dev,
>     Error **errp)
>     >              return;
>     >          }
>     > 
>     > -        if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
>     > +        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
>     >              cpu->phys_bits = 36;
>     >          } else {
>     >              cpu->phys_bits = 32;
>     > --
>     > 2.39.1
> 
> 


