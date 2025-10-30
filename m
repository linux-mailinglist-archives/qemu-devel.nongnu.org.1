Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E6C1FDE7
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Oct 2025 12:46:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vER3h-00056u-QF; Thu, 30 Oct 2025 07:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1vER3d-00056P-JE
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:43:09 -0400
Received: from pc232-62.mailgun.net ([143.55.232.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1vER3T-00086v-5p
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 07:43:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=dkim; t=1761824563; x=1761831763; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: From:
 References: Cc: To: To: Subject: Subject: MIME-Version: Date: Message-ID:
 Sender: Sender; 
 bh=BX8WMM54/X2z4JKKterrQ+u3+tKia/gkKKQAUuSGQIw=;
 b=BR9/mlZcGJOgzJb9C5XSJSqttREsKlgcbgvKqjAs3SPCxp5hoFCR5MAVUXL4FFT6MLi5Q318/y3y4cWHIoTIzt8mRR/z6qqWSOd13xPSYf5mkUPXzODliEMGOMsAB93HYj+QD+3GmICuQyvQaKXd2y2JERaVYXVmsG/zg/0bGCU=
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 82b7b0aa6a9490e1d37f90288d42dfc2781b07d0e3a3464ca437034ccc894751 with SMTP id
 69034f33e4319a89b6306c08; Thu, 30 Oct 2025 11:42:43 GMT
X-Mailgun-Sending-Ip: 143.55.232.62
Message-ID: <f1a0f03f-54b8-4fa8-8e03-b00a617bd462@yodel.dev>
Date: Thu, 30 Oct 2025 06:42:41 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] cpus: Constify some CPUState arguments
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 kvm@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>
References: <20250120061310.81368-1-philmd@linaro.org>
 <395c7c86-08b1-4af4-a5ca-012a9aa89339@linaro.org>
 <CAAjaMXZSkxCgzdC6w-onUxVxU_ZW5fiBtW5-ioeKaXwD_7tJeQ@mail.gmail.com>
Content-Language: en-US
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <CAAjaMXZSkxCgzdC6w-onUxVxU_ZW5fiBtW5-ioeKaXwD_7tJeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.62;
 envelope-from=bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev;
 helo=pc232-62.mailgun.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 30/10/2025 01:59, Manos Pitsidianakis wrote:
> On Wed, Oct 29, 2025 at 7:59 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 20/1/25 07:13, Philippe Mathieu-Daudé wrote:
>>> This is in preparation of making various CPUClass handlers
>>> take a const CPUState argument.
>>>
>>> Philippe Mathieu-Daudé (7):
>>>     qemu/thread: Constify qemu_thread_get_affinity() 'thread' argument
>>>     qemu/thread: Constify qemu_thread_is_self() argument
>>>     cpus: Constify qemu_cpu_is_self() argument
>>>     cpus: Constify cpu_get_address_space() 'cpu' argument
>>>     cpus: Constify cpu_is_stopped() argument
>>>     cpus: Constify cpu_work_list_empty() argument
>>>     accels: Constify AccelOpsClass::cpu_thread_is_idle() argument
>>
>> ping?
>>
> 
> Hi Philippe, I can't find this series in my mailbox and it's not on
> lore.kernel.org/patchew/lists.gnu.org either. Resend?
> 

Hi,

Looks like it landed on the kvm mailing list via Cc but was left out of
qemu-devel, despite the seemingly correct To header:

https://lore.kernel.org/kvm/20250120061310.81368-1-philmd@linaro.org/

Regards,
Yodel

