Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66962786F42
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 14:39:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ9am-0001kB-BO; Thu, 24 Aug 2023 08:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZ9ai-0001jl-BV
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:37:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZ9ag-0002FJ-5M
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:37:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fee8b78097so44988745e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692880652; x=1693485452;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjImE64TKhfUiC61WaWX4npQQW0zpzGzpdq9SPVc3vI=;
 b=bKrpVje/8H8lsRBVn4IOQ6P9KJjx4+B6fUyFYATirPxcCJntr3frDaiSHf7h1jK2Zj
 JUqTcgZ8lKPPhdV/UgyoYhzsL6/QAxj62v4aBg9g+9PU+qBm/8XzW0PztSJsXknEsGDD
 Axme9t+npzOxiCzADz3l5YRXjlCloKql1mzKomxiHI4eylkBl3Dv7j3HCQfTVG+C0uBH
 zCOk+MdfTfxNd5+dz1mH+mve+YYuhpYsQJ9OdakW20VOupr/sFwAvzlTcGxcMcxzrfhR
 4b/Ubk6CXgTF16hW/PbkE9oUbjQIizsabiyhkTqTmvHf0leo7erJ+IvRPMu81EV1A7QG
 rB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692880652; x=1693485452;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HjImE64TKhfUiC61WaWX4npQQW0zpzGzpdq9SPVc3vI=;
 b=O+R6q1JmCoD0v+JE5QC2CVHtq+z2J3gyYlToVDBB+XAaXbgpnXjh+syLUmsJokHS/E
 nVqEXYt2JBBw0DmFemGeglx+Ez/cwkR8jyqSWpfdPnZsCf0Qr8eLHistKkKhZRaFFk2e
 k+qOotT3G8QSlXKNGhWrytqtAPileAQrELQNvFrfQ/GgQOhr0Rikh1Z+XAoqgCAD+UD+
 xTFlYNF9JHvNQ3z70Y6duGMCZNcoRJXJ3/jeEYgzpxv6jjcBgFzIEyXch01XcPdtvGyf
 yjZJ2T7TkPnfhppUlI1SijjiVv29hWJ/KglktI8pO/SGnQk3b36Bofezcq79SjTtWEKP
 9uAA==
X-Gm-Message-State: AOJu0Yy9UrQELkxSgutjr8kb2EXAwjYa+QP5naoC5Uozx1m5+/Tqu1EV
 eweYGrUO6vGSeQRtvbH9ovwVfA==
X-Google-Smtp-Source: AGHT+IEOcfiorEERO7/hB0dZKmb4M8yYpsfdYh1wGWz2ckOHH8CpkNgsrK6scVXeoFxvoZxen9e+7w==
X-Received: by 2002:a1c:4b0f:0:b0:3fa:934c:8350 with SMTP id
 y15-20020a1c4b0f000000b003fa934c8350mr12369561wma.27.1692880652377; 
 Thu, 24 Aug 2023 05:37:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b00401b242e2e6sm419619wml.47.2023.08.24.05.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 05:37:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 57AC81FFBB;
 Thu, 24 Aug 2023 13:37:31 +0100 (BST)
References: <20230817053017.24207-1-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Richard
 Henderson <richard.henderson@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael
 Rolnik <mrolnik@gmail.com>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, Brian Cain <bcain@quicinc.com>, Song Gao
 <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Laurent
 Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>, Chris Wulff <crwulff@gmail.com>, Marek
 Vasut <marex@denx.de>, Stafford Horne <shorne@gmail.com>, Daniel Henrique
 Barboza <danielhb413@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, David
 Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Nicholas
 Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Max Filippov
 <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, Anton
 Kochkov <anton.kochkov@proton.me>
Subject: Re: [PATCH v5 00/26] plugins: Allow to read registers
Date: Thu, 24 Aug 2023 13:36:43 +0100
In-reply-to: <20230817053017.24207-1-akihiko.odaki@daynix.com>
Message-ID: <87wmxkfwfo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> I and other people in the University of Tokyo, where I research processor
> design, found TCG plugins are very useful for processor design
> exploration.

This series didn't seem to complete getting to the mailing list. Can you
re-post or send the next iteration?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

