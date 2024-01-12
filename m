Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D2D82C133
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:56:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOI18-0007ug-3x; Fri, 12 Jan 2024 08:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOI15-0007n0-Gn
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:56:11 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOI13-0002Vd-Nr
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:56:11 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso17016675e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 05:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705067768; x=1705672568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOB8JnVE3SX6iRInWd6TCVKBhgs5LElYDobunt8K5us=;
 b=U6UhZZQFVWlPzrntxD9Uv9qGUJsOQA0g6f52Y6CaNyaiNW/Rdkm6TVHQ2r+cQ9RYxG
 74pSAhnholL78NVkIHBGj7Z2iQ6CIJn0Wy8JyQKZ9YnHBpjSt2uF0n/2OkjLZkfWg/cG
 R+JYODWmI/lG9FAjyq+OudX8TbWGmfSwoPhfFalixi33T81KV46WdjGLGhlsHnXqvcsF
 1WjOTqaTPeB4rfA4a3BAsirK6xnYuuqScJtmtpNf4XSIVoUFEx4/HXoGUNAitknkr6V9
 GcR6WyETQxLLkTsdf/+ckT3cAQn84MPaWZfxqvdWQczWPxpzTyxZ0QKYBkvqGMbydYMa
 o1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067768; x=1705672568;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AOB8JnVE3SX6iRInWd6TCVKBhgs5LElYDobunt8K5us=;
 b=erzWHN+fOVZyY8XivItDnWF5C5cjTkc2Y6elAA9eBq95hnmhj1sph4IWbgWmiV0sae
 Tzjj2vt721yNBVuAI9vCi3/80Fjbo5Et8HMu0uk7hyukLbsPdOdZ6ga31GRwA7jaOZUX
 w1w7Az7JCeRxJocDpUVsjAo8uoHSbf4Pzd91QgC2lyjW9uH77f1N5ESVRaO4ZKBC/ly3
 Mp3j5fGCnp1CIfOhH4G3Zz9Sj/DWUd/SX7OAwMY7UqtmHWQ5f4URsg1c30k7w6QFTlGd
 Iu2IH/9bmtSUa+APgmjBCPVZUOcgi7fJ3J0iW1lUu2Xm2QxgQs13uB6/On12YtuY5fxy
 pOQg==
X-Gm-Message-State: AOJu0YzWvkt4LKVjkdOBKeO88n/C2aGyNsOQCJdN/QFaFGqOLUygcqlp
 S/OxnLf6osEw6AlilcbQZxb4yEfwAk9Ulg==
X-Google-Smtp-Source: AGHT+IEa5aOGGd6elo7lF7xI4ybVKMItLa9QTtJ7HJRr3ckjMycVA8LjLnWzE+WcGqMlocCBDGvr7A==
X-Received: by 2002:a05:600c:45ca:b0:40e:45be:3d92 with SMTP id
 s10-20020a05600c45ca00b0040e45be3d92mr877069wmo.106.1705067768203; 
 Fri, 12 Jan 2024 05:56:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c358a00b0040e559e0ba7sm9611323wmq.26.2024.01.12.05.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:56:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7116D5F760;
 Fri, 12 Jan 2024 13:56:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org,  Palmer Dabbelt <palmer@dabbelt.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v2 23/43] target/riscv: Remove misa_mxl validation
In-Reply-To: <CAKmqyKPCy9W-iYscHLjVvU=RfoSLURFgdki0qdzgNSkLKqutyg@mail.gmail.com>
 (Alistair Francis's message of "Fri, 12 Jan 2024 09:29:35 +1000")
References: <20240103173349.398526-1-alex.bennee@linaro.org>
 <20240103173349.398526-24-alex.bennee@linaro.org>
 <87sf37hlwo.fsf@draig.linaro.org>
 <CAKmqyKPCy9W-iYscHLjVvU=RfoSLURFgdki0qdzgNSkLKqutyg@mail.gmail.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 12 Jan 2024 13:56:07 +0000
Message-ID: <875xzyejuw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Alistair Francis <alistair23@gmail.com> writes:

> On Tue, Jan 9, 2024 at 1:43=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>> > From: Akihiko Odaki <akihiko.odaki@daynix.com>
>> >
>> > It is initialized with a simple assignment and there is little room for
>> > error. In fact, the validation is even more complex.
>> >
>> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> > Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> > Message-Id: <20231213-riscv-v7-2-a760156a337f@daynix.com>
>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ping: along with this are the RiscV maintainers happy for me to take:
>>
>>   [PATCH v2 23/43] target/riscv: Remove misa_mxl validation
>>   [PATCH v2 24/43] target/riscv: Move misa_mxl_max to class
>>   [PATCH v2 25/43] target/riscv: Validate misa_mxl_max only once
>>
>> through my next pull request?
>
> Yep! Go for it

Sadly some of the recent changes that went through have created a merge
conflict.

Akihiko,

Any chance you could re-spin just the MISA_MXL patches?

>
> Alistair
>
>>
>> <snip>
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

