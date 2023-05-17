Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FDB706F12
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:09:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKde-0002Sa-J2; Wed, 17 May 2023 13:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzKdc-0002S0-Hw
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzKdb-0004tG-3y
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684343309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=euzWBX0Teoo5wQyGZCHthOnt2mmhh1x5Mo0hEx/AOqI=;
 b=gzzHLBPDwkPM3r9BwOqeWHTRaxpADnNJbU0Pv0mCBcDdXVui5dRtzlo9KxEUakybVaFmQT
 neCbWbVpqMcXO2QqyyMXxhYmxGQbgG3Mp7UzUPR9YqXIHRm/RuhakXnjaRTWCEwR+S3pqI
 z9kGZziZG55Xb3MO8d8WjES2K0/hq1s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-NUhqhBL-PNSw5T1LmGzEzw-1; Wed, 17 May 2023 13:08:18 -0400
X-MC-Unique: NUhqhBL-PNSw5T1LmGzEzw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3062dedf7d9so726682f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684343297; x=1686935297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=euzWBX0Teoo5wQyGZCHthOnt2mmhh1x5Mo0hEx/AOqI=;
 b=gYAPPhDq2h5lEd1BD07caC7V7CP0kmbfvhA8QKKpzy0BZ4yvrrXk0/hbyi/yDJ6dbB
 s9d+y/gyo4Coco9X002NgztcFL4ZijUoYox/dX5AK9HLOHb5gqbQtkJn9GgqICk73h+M
 q51l58OpM4d2QYhX03zkZEqx7/yxQhnk1H0jFWvq7zkYXssVz9D3PDuH/w7zWCSamsUe
 vvRKwfY55oekKsXM9TPR0Hgysvb6nJBH4cmIzTDcPE3zHJvfRY+7wIGZ86RSyQAu+8a0
 hXReNGLwx7MjrVgb4Sqf09qGGpgC6osRNNiOKzWZP/RDJ4umy1c0v0KX87m54O57gNCU
 kT9w==
X-Gm-Message-State: AC+VfDzs2OIi3punm83z/ZyV4avOtzEDx6taJqDG1lypdzBZjkUYTy4P
 QLnxT7QJ3H3OuXJRN0LGYuMh/RnrM7ptKO0l74ePnQw7lA0ZjqLmt2+O9gIM82i9PgQ3HTnf/kg
 HEKJn8CGRW+R8WEk=
X-Received: by 2002:adf:f684:0:b0:2fb:283a:1757 with SMTP id
 v4-20020adff684000000b002fb283a1757mr1340499wrp.26.1684343297576; 
 Wed, 17 May 2023 10:08:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76uxaJZrofTboIok3L/R+F2mdGA6Hije2wTR+MG6m641o5Qm3A8/aQXQ0OkmwWgMI/C4ciyg==
X-Received: by 2002:adf:f684:0:b0:2fb:283a:1757 with SMTP id
 v4-20020adff684000000b002fb283a1757mr1340484wrp.26.1684343297235; 
 Wed, 17 May 2023 10:08:17 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 s5-20020adfdb05000000b00307a83ea722sm3318015wri.58.2023.05.17.10.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 10:08:16 -0700 (PDT)
Message-ID: <0a734157-778b-8d33-3999-b374a68a3c39@redhat.com>
Date: Wed, 17 May 2023 19:08:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/i386: Clear xsave pkru bit when KVM XCR0 not
 support
Content-Language: en-US
To: Yuchen <yu.chen@h3c.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 Chengchiwen <chengchiwen@h3c.com>
References: <914d4bfc6901485c9f029ce26ceb7d10@h3c.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <914d4bfc6901485c9f029ce26ceb7d10@h3c.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/17/23 12:55, Yuchen wrote:
> Migrating guest from Intel new CPU (as Gold 6230) to old CPU (as
> E5-2650 v4) will pause on the destination host. Because old CPU
> not support xsave pkru feature, and KVM KVM_SET_XSAVE ioctl
> return EINVAL.
> 
> This kernel commit introduces the problem:
> 
> ea4d6938d4c0 x86/fpu: Replace KVMs home brewed FPU copy from user
> 
> Signed-off-by: YuChen <yu.chen@h3c.com>

Would this work instead?

diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfef5..d3e5edad2ecd 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -47,7 +47,7 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
          stq_p(xmm + 8, env->xmm_regs[i].ZMM_Q(1));
      }
  
-    header->xstate_bv = env->xstate_bv;
+    header->xstate_bv = env->xstate_bv & x86_cpu_xsave_xcr0_components(cpu);
  
      e = &x86_ext_save_areas[XSTATE_YMM_BIT];
      if (e->size && e->offset) {

Paolo


