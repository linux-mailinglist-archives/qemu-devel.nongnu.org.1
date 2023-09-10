Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A69579A002
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 23:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfRX6-00018X-W8; Sun, 10 Sep 2023 16:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qfRX4-00018I-S9
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 16:59:50 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1qfRX2-000774-Qo
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 16:59:50 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bcd7a207f7so59806071fa.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 13:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1694379586; x=1694984386; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=km2nfUBS1QC1wQmwYAoMOvcjcYP4HrO1QMXT7Yqhn8Y=;
 b=TSDN/DUmXLZMw6aIquY7QP4osYg9Gt3FLPcRRMRrbn7BeSpLP/0uZEB/TzXcfm2MLh
 wkukmHuQXiV1/gTaM1OWj7AZ54+pJkNE6kaIgenZadL8bOu871n93hHiS3xMkbk0lmKu
 nYZF+tLdd0bir7SJ6K6ukinecdbtIaCTqWyoDkZfh1Mpd7w5mkMktV5ZD6sdHaek2BIZ
 zmWvVMKdQrpj8LpSlbyi9wR4Emf9keQ86CDc9H/9dZmKigqwyalVbIQr6LEUfS4vbieG
 WrsElEEwNB7ajCR5BuM264ydnl6+E0urPMaqtWDPsMBOA/Y7OVqIJEHqpSkXT2s6tHpX
 MDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694379586; x=1694984386;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=km2nfUBS1QC1wQmwYAoMOvcjcYP4HrO1QMXT7Yqhn8Y=;
 b=a3QKE5eCMCvvnTGa6PBMb0gRO0189vW56m47RXVJiEiTTh5l2iXvP4gFVQFLxZOKkw
 4mnSiGuLIjhDElm75uy2wbEUL66XwVYos1NaJkFKqd2GyZx4inB9u2zrVjGCdf3Ii35i
 HwD5c/7v8LjFWKd/YLheFsCQAON6kSitojeM7edg8cwMG0z7Vo8NgbbZA0t+O0PJvwtz
 iiF8lKwXcMwlukH/aolM0iv8MW/0Fic6Nd32NRMJlJofvl3pQpZoyHDO7t/QW+70dVss
 oZ2OHT9RF5FLui4ntnGGRO52gklHUBeEC//cmq/OuU9JmWWJ/bk2h01L6mq+IRwKLTdq
 iFAQ==
X-Gm-Message-State: AOJu0Ywe+xhSi5gF1pMDkqv2TAgsjHE7Kb1Z57LZ0v8yqv969h676UmZ
 SbWlnwF6vUBQ5cJhUAr+WfbsnQ==
X-Google-Smtp-Source: AGHT+IHawdTdpu36lCuFL2SjxTayH3GFZ8p8YpLkoFCBk51DIhovVtpJ5rwut8V6KUd3LBDTeq9giA==
X-Received: by 2002:a2e:880d:0:b0:2bc:b557:cee9 with SMTP id
 x13-20020a2e880d000000b002bcb557cee9mr6246408ljh.43.1694379586289; 
 Sun, 10 Sep 2023 13:59:46 -0700 (PDT)
Received: from localhost ([149.255.29.239]) by smtp.gmail.com with ESMTPSA id
 v16-20020a2e7a10000000b002bcda31af28sm1236468ljc.42.2023.09.10.13.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 13:59:45 -0700 (PDT)
Date: Sun, 10 Sep 2023 23:59:42 +0300
From: Roman Bolshakov <roman@roolebo.dev>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH 2/2] sysemu/kvm: Restrict hvf_get_supported_cpuid() to
 x86 targets
Message-ID: <ZP4uPozEl3pjY2qg@MacBook-Air-Roman.local>
References: <20230905123906.6880-1-philmd@linaro.org>
 <20230905123906.6880-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230905123906.6880-3-philmd@linaro.org>
Received-SPF: none client-ip=2a00:1450:4864:20::22e;
 envelope-from=roman@roolebo.dev; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 05, 2023 at 02:39:06PM +0200, Philippe Mathieu-Daudé wrote:
> hvf_get_supported_cpuid() is only defined for x86 targets
> (in target/i386/hvf/x86_cpuid.c).
> Its declaration is pointless on all other targets.
> 
> All the calls to it in target/i386/cpu.c are guarded by
> a call on hvf_enabled(), so are elided when HVF is not
> built in. Therefore we can remove the unnecessary function
> stub.
> 

Looks good but you also need to include "hvf/hvf-i386.h" to
target/i386/hvf/hvf-cpu.c, otherwise the build fails.

--Roman

