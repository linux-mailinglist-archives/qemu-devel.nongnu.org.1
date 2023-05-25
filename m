Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8DF711A84
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:20:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KEk-0004UB-KQ; Thu, 25 May 2023 19:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q2KEj-0004U1-1S
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:19:13 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q2KEh-0003ff-G1
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:19:12 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4A46C74635C;
 Fri, 26 May 2023 01:19:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 11D0E74633D; Fri, 26 May 2023 01:19:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1025B745720;
 Fri, 26 May 2023 01:19:10 +0200 (CEST)
Date: Fri, 26 May 2023 01:19:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Richard Henderson <richard.henderson@linaro.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
In-Reply-To: <13671ccd-8048-d60f-89df-a0306f053657@redhat.com>
Message-ID: <6a33e610-0168-ad52-1d47-dacc2862744f@eik.bme.hu>
References: <20230523131107.3680641-1-alex.bennee@linaro.org>
 <8920aa58-505c-92df-cff0-4ee232ca6f8b@eik.bme.hu>
 <65f5f7e7-4685-1a63-1551-b71308c88021@linaro.org>
 <13671ccd-8048-d60f-89df-a0306f053657@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1279399418-1685056750=:5836"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1279399418-1685056750=:5836
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 25 May 2023, Paolo Bonzini wrote:
> On 5/23/23 16:33, Richard Henderson wrote:
>> 
>> The tests are poorly ordered, testing many unlikely things before the most 
>> likely thing (normal).  A better ordering would be
>>
>>      if (likely(tp##_is_normal(arg))) {
>>      } else if (tp##_is_zero(arg)) {
>>      } else if (tp##_is_zero_or_denormal(arg)) {
>>      } else if (tp##_is_infinity(arg)) {
>>      } else {
>>          // nan case
>>      }
>
> Might also benefit from a is_finite (true if zero or normal or denormal) 
> predicate, to do
>
> if (tp##_is_finite(arg)) {

There seems to be only is_infinity but I'm not sure if is_finite would be 
the same as !is_infinity so could not try this. But it seems having any 
branches kills performance so adding more branches may not help (also 
because infinite values may be less frequent so not sure why this would 
be better).

Regards,
BALATON Zoltan

>    if (!tp##_is_zero_or_denormal(arg)) {
>       // normal
>    } else if (tp##_is_zero(arg)) {
>    } else {
>       // denormal
>    }
> } else if (tp##_is_infinity(arg)) {
> } else {
>    // nan
> }
>
> since is_normal is a bit more complex and inefficient than the others. The 
> compiler should easily reuse the result of masking away the sign bit.
>
> Paolo
>
>
--3866299591-1279399418-1685056750=:5836--

