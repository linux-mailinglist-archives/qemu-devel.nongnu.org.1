Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 616457BEE68
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 00:43:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpywR-0001nP-3f; Mon, 09 Oct 2023 18:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpywN-0001l9-QD
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 18:41:31 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qpywF-0008Ra-6B
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 18:41:31 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-504b84d59cbso6664429e87.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1696891281; x=1697496081; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=63JRvopVxTzbYjYF0p1oEt+aEjewWFFf5DMgWxLKsuc=;
 b=dHnF4VtBCREPdHNds2buZFgjZnHI4tOHYCbYGr34/IMopxMTh5CWeK7snaUZtvgfxa
 VvdvSUiqE5OtoT1MyT8V3UqxpHP9LdY3/u11ChER6ESEjUFFhD0lW3exyoCVX6tU3jRE
 5z6e0pzSo6yEqx1tALw/bqNIfL+QsHTwotsGDBKUsk4+okK2PJjeexLcAQZ31yeMRuur
 p0P/JASxbwINsuhSz8y2oCy6Hn+NNW9CLoUe+OVXxTKwhaweM+sBECuDYe3qq4I63W2S
 FGT0KNfYM9l6KkY8t81jPGvEa3akgyeatROV3gTC0ANUHXoU0eigYdZOkfF3zwiXDuLV
 d41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696891281; x=1697496081;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63JRvopVxTzbYjYF0p1oEt+aEjewWFFf5DMgWxLKsuc=;
 b=F4xc5jfLDwsjIeuyKI8zKp6nGHe41ORJPK6Y9b+v56J4bYNeWP6KWTcmRT+pKUoyUD
 7no82MIzhS+3XUbutDsOgNLX4t8HCUpPGmVPsq9XkP5Ts46e+eqiWI2UheNU2HdkhKsn
 jMW4S+vCroVVx4d3py8xLCGLETiwsviXgGnd2r/5uSR1uhDz3/RhPK+52lZp0vm17IxU
 UrWIOsCvAt7u3C75SGo0PcWj11sk5hcTcD+n3McORw+Sih5+M7D6P/EhflK7UV9A9b91
 i3yTEWfyT6MTE70UuacIOlTS2toi92GuDXOINVz4NKhSTDscx/JEGmb2BgYsF11oCQfX
 X9qg==
X-Gm-Message-State: AOJu0YwSdd8N5NRE2vsM+/wceeus3eW9cVM2L0QZzgd7jIxNQ2BbkZv+
 3BsCudHA1y4tVP1sASlZb5dPzA==
X-Google-Smtp-Source: AGHT+IFk6UylV9E97y/hgkYNBPIOrrHYH5JyI2duIm4+sYcCcbh1TZ9QY+nS5w6/50XF1GfPfsY68w==
X-Received: by 2002:a05:6512:758:b0:503:59d:fbff with SMTP id
 c24-20020a056512075800b00503059dfbffmr5825067lfs.2.1696891281365; 
 Mon, 09 Oct 2023 15:41:21 -0700 (PDT)
Received: from localhost (95-25-87-177.broadband.corbina.ru. [95.25.87.177])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a19f010000000b00500b19152cbsm1578228lfc.8.2023.10.09.15.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 15:41:20 -0700 (PDT)
Date: Tue, 10 Oct 2023 01:41:19 +0300
From: Roman Bolshakov <roman@roolebo.dev>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Cameron Esfahani <dirty@apple.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-riscv@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 6/6] target/i386: Use env_archcpu() in
 simulate_[rdmsr/wrmsr]()
Message-ID: <ZSSBjyb1v75yefyg@roolebo.dev>
References: <20231009110239.66778-1-philmd@linaro.org>
 <20231009110239.66778-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009110239.66778-7-philmd@linaro.org>
Received-SPF: none client-ip=2a00:1450:4864:20::136;
 envelope-from=roman@roolebo.dev; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 09, 2023 at 01:02:39PM +0200, Philippe Mathieu-Daudé wrote:
> 
> simulate_rdmsr/simulate_rdmsr(CPUX86State
> 

Hi Philippe, the above is likely a typo. The subject may also be changed to
target/i386/hvf.

> RFC: Not even build-tested.
>

The patch compiles and works fine. Besides the nits,

Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>

Thanks,
Roman

