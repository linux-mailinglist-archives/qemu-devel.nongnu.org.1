Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70682D893
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:52:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPLV7-00057Y-44; Mon, 15 Jan 2024 06:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPLV5-00057J-WE
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:51:32 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPLV4-0002iQ-BU
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:51:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-336755f1688so7628820f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 03:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705319488; x=1705924288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9l19L6rbX05ONRegK7vqFjOSqqycukFWTq6UAM6eNyI=;
 b=du+VdGR5c6jbnaWy1/BBj924g9Tz8YQkt/5/lr8khXn8V4AFrJanh+6o0vjpcXSp+A
 zOF0YSa6tJcCbxZAVuKPnEX0VUfnv96NpPefYh2V4G4qea44ZnXkN786P7WuU9GmGOoD
 HAccITU+p6ZbTi6f9YWw7UbmruXWInvY8Ku8oV36YPOlRm2iu9vBLZIGI6U1dr24+59+
 VWPD2Dz/bcikncoQxBpNYaj69eImeTvHyVWS4+PYi8Ve9+640qRLcTQQAraleo9jy9N2
 AEqo+lPthz236ldgN6exUx25fVzp2v4Z5msNZDQAEzwcDlWwfxeF8WOI2Hw/3TUc8Of+
 GvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705319488; x=1705924288;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9l19L6rbX05ONRegK7vqFjOSqqycukFWTq6UAM6eNyI=;
 b=QoEx8wF9pj2H3PG7xPGlwd8f35NVJ9AOi6BAcIFlRPTTM+ROhELt4Si3zLFGcZf+DV
 rnkEzYBNW7dXd9rveBsBkoLH9JYCHD+IRyItttz6vjY+ssGrZRjgu2gLMBuYF+OKc6aS
 o/8k3FNxyJPoyrn/Iibe/TVaBQ1eWuwFG7ef0MYxvW+X8YQDj11DTimLEXLSMHROz2eM
 CNkyASuWYOhAwFQo+IgsTNWv1ypurIan97+EjYSybMex8CrR6Gk1W+2daJ4C8R7TvIJg
 f65lf2c7fBtZdiFQVvrZ6QE1IDUEpv24D8D9IYRLKP/8biaF1HqWc7IYECViI+W0rf3v
 12KA==
X-Gm-Message-State: AOJu0YzPzK6j971kHt8EaQJ5G3EUakq8aS8bj0+uj7Lt1BqCjB6rD4vZ
 daR7ZvrcR9Tfa2x8UXF/XkHrBX1ctaY2CA==
X-Google-Smtp-Source: AGHT+IH3GpcUGafFfT+70R3lWyRyo45Gv5/bjAAhsnh/tJGw8bX+nySaHK9E3jA5toNz5o2Q4P6Ssg==
X-Received: by 2002:a05:600c:3b2a:b0:40e:621b:639b with SMTP id
 m42-20020a05600c3b2a00b0040e621b639bmr2872190wms.116.1705319488061; 
 Mon, 15 Jan 2024 03:51:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p19-20020adf9d93000000b003362d0eefd3sm11633639wre.20.2024.01.15.03.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 03:51:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61A965F78A;
 Mon, 15 Jan 2024 11:51:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org,  Palmer Dabbelt <palmer@dabbelt.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org,  Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v2 23/43] target/riscv: Remove misa_mxl validation
In-Reply-To: <875xzyejuw.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Fri, 12 Jan 2024 13:56:07 +0000")
References: <20240103173349.398526-1-alex.bennee@linaro.org>
 <20240103173349.398526-24-alex.bennee@linaro.org>
 <87sf37hlwo.fsf@draig.linaro.org>
 <CAKmqyKPCy9W-iYscHLjVvU=RfoSLURFgdki0qdzgNSkLKqutyg@mail.gmail.com>
 <875xzyejuw.fsf@draig.linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 15 Jan 2024 11:51:27 +0000
Message-ID: <87a5p6ke68.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Alistair Francis <alistair23@gmail.com> writes:
>
>> On Tue, Jan 9, 2024 at 1:43=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>>
>>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>>
>>> > From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> >
>>> > It is initialized with a simple assignment and there is little room f=
or
>>> > error. In fact, the validation is even more complex.
>>> >
>>> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> > Acked-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>>> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
>>> > Message-Id: <20231213-riscv-v7-2-a760156a337f@daynix.com>
>>> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>>> ping: along with this are the RiscV maintainers happy for me to take:
>>>
>>>   [PATCH v2 23/43] target/riscv: Remove misa_mxl validation
>>>   [PATCH v2 24/43] target/riscv: Move misa_mxl_max to class
>>>   [PATCH v2 25/43] target/riscv: Validate misa_mxl_max only once
>>>
>>> through my next pull request?
>>
>> Yep! Go for it
>
> Sadly some of the recent changes that went through have created a merge
> conflict.
>
> Akihiko,
>
> Any chance you could re-spin just the MISA_MXL patches?

Never mind, I think I got it figured out.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

