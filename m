Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8187880E6
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:33:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRIc-0000hW-Vb; Fri, 25 Aug 2023 03:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRIA-0000em-9S
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:31:41 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRI4-0005lW-P7
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:31:36 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fe1b00fce2so890130e87.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692948688; x=1693553488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QtUKgvKARl40I7Fd/UN9egDPP0h5VEUmBVJ6Nb1u2fU=;
 b=fr26ym6AHvoshWMNWRYTe3qFCxj2ShXDBqErVsibOh11pvnNINHtLgKpP+80Jbyv/t
 lR9mg1pc467H/WgiaPZ9RmjWac8V6Kr6Sg8NAZaLylQtUcRNSBDsBmZ5v4l8JUm/ODOx
 UMqQ3ISWGbVrOmzhPaAz7yFyHNJrbySL8r7ESwm0W7rR00ZrdCYhXSRzAhyB/1n5PxIV
 UQHWvVuC6Twd1VhgyBmCyPMwJOp3MQrq6aytbNLCAYkk1dBBS4wyrzPaauCGdYbJjN8L
 cNXEk19BrUUJ1AJL09uZXcax4sLFjE0rWyvpiDbVtmKI5p1coWIZQBAR/LB61fapSWaR
 z5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692948688; x=1693553488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QtUKgvKARl40I7Fd/UN9egDPP0h5VEUmBVJ6Nb1u2fU=;
 b=OQ8U+sLkwoIeGbswpC7f/Ael8hsjOlQjmQLmbmsIB7hW0E0FKblGpD2RCCme41prTU
 2No/t91oxvCI2LWzM+HXi7h4vR0LtrBZGUPiOcjIgKiARqGClSn/SUW73orDkk8ujw17
 orSgcXg6BB+toraw1TER/AXxzQGDWmapBKrUIPlvlzUOuPBeiqnM1/gvMCoNtPoiCvYm
 XZHXCpu+csyq0W0WfHU5zSRl15WSnLSKRLoP9B/9FyvpU1pwUcxPcNmWRVQLT1A0Oxjc
 ioZpd1wZYyKBRsoaMEX39gPq+bw2wFCEajy/lzf+JDlXeGiOZ33IbkN70pscIF3a/H6A
 sQmw==
X-Gm-Message-State: AOJu0Yy4poGncUwpanPT5U6vbKOy9cgi2gugFHD2fC6f7IgRet9PFj+C
 gYAioL0XYpyoMDRMBjt4TSNaQQ==
X-Google-Smtp-Source: AGHT+IGQK+tbW+b/sW3c9kYHBzbF/JrctTB0fzkD9PAGgwdoWsomRzS+bT7A2KZIL/tzKbOs7gT7Aw==
X-Received: by 2002:a05:6512:aca:b0:500:9f7b:e6a4 with SMTP id
 n10-20020a0565120aca00b005009f7be6a4mr3805893lfu.32.1692948688145; 
 Fri, 25 Aug 2023 00:31:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a7bcbd7000000b003fef6881350sm1412685wmi.25.2023.08.25.00.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:31:27 -0700 (PDT)
Message-ID: <e81f9d03-b52d-6ea5-4f4e-1bdc69a88d56@linaro.org>
Date: Fri, 25 Aug 2023 09:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 09/12] gdbstub: remove unused user_ctx field
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-arm@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
 <20230824163910.1737079-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824163910.1737079-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/8/23 18:39, Alex Bennée wrote:
> This was always NULL so drop it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   gdbstub/gdbstub.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


