Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B92C710D29
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:24:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AvR-0002Kq-U4; Thu, 25 May 2023 09:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2AvP-0002Ke-EL
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2AvN-0003Mx-OA
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685020956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQ/jPBwEYF5QfIsLieFKHfj9jvymk5OtIb7oY4RB6TI=;
 b=b6W9uYZqxQUBC8+FMDBVo3aDuVfd/HXQiYz2c6paiBOi55ahLyvy05zlPqKdx+UExFkvyI
 Axg7oX1qtV3HJ6/TLKDj4AL+2EDgvPtsDRvldsoVAaiWW/Wqq8uoIiiPk4sr+YP3GJMYon
 s/Ymu13VMg+j/by8D5U4AzNx20LOQ14=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-9kYLbs_wMMqCPjX-9mPk0g-1; Thu, 25 May 2023 09:22:34 -0400
X-MC-Unique: 9kYLbs_wMMqCPjX-9mPk0g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9737cde2ce8so70823866b.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685020953; x=1687612953;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rQ/jPBwEYF5QfIsLieFKHfj9jvymk5OtIb7oY4RB6TI=;
 b=EPmqpMDfONSM7qQqNY8RFVsDVzCURhTMK5RGAuYXilO0z6aFzc/z3zSYq0FPO7hJBs
 WGi/Bi+H0f+t+IQZPSa/IRjax2K8oaoDXG44FNCyhFVIne3evZ+6knUGEtY0Vi2b1+3S
 Cq1QokiJMCg3phxcXpmvUbO0PSI8hxALd1AW4a3hlwxNTiac1JpRL5cUBqu5x4qsvpUK
 2SrcDIaNBznwjxmUhVcMb5TClW0i6CLvtsKxGfXDVHYxFS/ThlVfqedEphn1AZf92/s6
 tZax5LketyfAyykuV4CfDGzXUbteFqPXpUP/+Q1C1VzSU1OYhVisyA1CxPpf6WynOYhp
 v+1w==
X-Gm-Message-State: AC+VfDyv8LthmEzFJP/ZSUoLrCTzzny4oEvK3+XODs8pACZKqH9EgVzX
 OXElOLvkoRFSDaCRMGN3fOuhuBqSCP1M7+RvDCigHPaWWWIMypRU5ao27ZhKHu91+9ycoqCXep3
 UkFj9RnVbxj/am/M=
X-Received: by 2002:a17:907:7fa2:b0:95f:64d8:f795 with SMTP id
 qk34-20020a1709077fa200b0095f64d8f795mr1699870ejc.27.1685020953255; 
 Thu, 25 May 2023 06:22:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56HnzTUvSAgiJCiSUhNZhuiKU7mnWesCpwt5EfnNI/WVj1HGHvCPj/7SSy/PMTo0RwIpirwQ==
X-Received: by 2002:a17:907:7fa2:b0:95f:64d8:f795 with SMTP id
 qk34-20020a1709077fa200b0095f64d8f795mr1699850ejc.27.1685020952908; 
 Thu, 25 May 2023 06:22:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:48f9:bea:a04c:3dfe?
 ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.googlemail.com with ESMTPSA id
 d21-20020a170906371500b0094f1fe1696bsm835011ejc.216.2023.05.25.06.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 06:22:32 -0700 (PDT)
Message-ID: <77189848-d618-9f55-4ae9-92756e635371@redhat.com>
Date: Thu, 25 May 2023 15:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
 <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
 <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/23/23 16:33, Richard Henderson wrote:
> 
> 
> The tests are poorly ordered, testing many unlikely things before the 
> most likely thing (normal).  A better ordering would be
> 
>      if (likely(tp##_is_normal(arg))) {
>      } else if (tp##_is_zero(arg)) {
>      } else if (tp##_is_zero_or_denormal(arg)) {
>      } else if (tp##_is_infinity(arg)) {
>      } else {
>          // nan case
>      }
> 
> Secondly, we compute the classify bitmask, and then deconstruct the mask 
> again in set_fprf_from_class.  Since we don't use the classify bitmask 
> for anything else, better would be to compute the fprf value directly in 
> the if-ladder.

So something like this:

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index a66e16c2128c..daed97ca178e 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -141,62 +141,30 @@ static inline int ppc_float64_get_unbiased_exp(float64 f)
      return ((f >> 52) & 0x7FF) - 1023;
  }
  
-/* Classify a floating-point number.  */
-enum {
-    is_normal   = 1,
-    is_zero     = 2,
-    is_denormal = 4,
-    is_inf      = 8,
-    is_qnan     = 16,
-    is_snan     = 32,
-    is_neg      = 64,
-};
-
-#define COMPUTE_CLASS(tp)                                      \
-static int tp##_classify(tp arg)                               \
-{                                                              \
-    int ret = tp##_is_neg(arg) * is_neg;                       \
-    if (unlikely(tp##_is_any_nan(arg))) {                      \
-        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
-        ret |= (tp##_is_signaling_nan(arg, &dummy)             \
-                ? is_snan : is_qnan);                          \
-    } else if (unlikely(tp##_is_infinity(arg))) {              \
-        ret |= is_inf;                                         \
-    } else if (tp##_is_zero(arg)) {                            \
-        ret |= is_zero;                                        \
-    } else if (tp##_is_zero_or_denormal(arg)) {                \
-        ret |= is_denormal;                                    \
-    } else {                                                   \
-        ret |= is_normal;                                      \
-    }                                                          \
-    return ret;                                                \
-}
-
-COMPUTE_CLASS(float16)
-COMPUTE_CLASS(float32)
-COMPUTE_CLASS(float64)
-COMPUTE_CLASS(float128)
-
-static void set_fprf_from_class(CPUPPCState *env, int class)
+static void set_fprf(CPUPPCState *env, uint8_t ret)
  {
-    static const uint8_t fprf[6][2] = {
-        { 0x04, 0x08 },  /* normalized */
-        { 0x02, 0x12 },  /* zero */
-        { 0x14, 0x18 },  /* denormalized */
-        { 0x05, 0x09 },  /* infinity */
-        { 0x11, 0x11 },  /* qnan */
-        { 0x00, 0x00 },  /* snan -- flags are undefined */
-    };
-    bool isneg = class & is_neg;
-
      env->fpscr &= ~FP_FPRF;
-    env->fpscr |= fprf[ctz32(class)][isneg] << FPSCR_FPRF;
+    env->fpscr |= ret << FPSCR_FPRF;
  }
  
-#define COMPUTE_FPRF(tp)                                \
-void helper_compute_fprf_##tp(CPUPPCState *env, tp arg) \
-{                                                       \
-    set_fprf_from_class(env, tp##_classify(arg));       \
+#define COMPUTE_FPRF(tp)                                       \
+void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)        \
+{                                                              \
+    int ret;                                                   \
+    if (tp##_is_normal(arg)) {                                 \
+        ret = 0x0408;                                          \
+    } else if (tp##_is_zero(arg)) {                            \
+        ret = 0x0212;                                          \
+    } else if (tp##_is_zero_or_denormal(arg)) {                \
+        ret = 0x1418;                                          \
+    } else if (unlikely(tp##_is_infinity(arg))) {              \
+        ret = 0x0509;                                          \
+    } else {                                                   \
+        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
+        ret = (tp##_is_signaling_nan(arg, &dummy)              \
+               ? 0x0000 : 0x1111);                             \
+    }                                                          \
+    set_fprf(env, tp##_is_neg(arg) ? (uint8_t)ret : ret >> 8); \
  }
  
  COMPUTE_FPRF(float16)


Not tested beyond compilation, but if Zoltan reports that it helps
I can write a commit message and submit it.

Paolo


