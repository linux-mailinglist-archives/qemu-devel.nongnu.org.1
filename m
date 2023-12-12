Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3180080E366
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 05:40:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCuYT-00044t-HM; Mon, 11 Dec 2023 23:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rCuYR-00044c-7M
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:39:35 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rCuYP-0000bM-Qs
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 23:39:34 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-58e256505f7so2854010eaf.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 20:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702355972; x=1702960772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7kKjpYgRbPhgH5U+ZaCrjOh/6654v55c2tM22nE+pfo=;
 b=F0E0VUTwbonvUEQDFUpEIvUvsJhgLlPfoQnO3+b7NGFveGtO/5RVpqGSU8bU0hnU6p
 l/BbwJ4V7WklaLvaDqzND/8umo7ueIpxbyW0Qyo+PXpmV17nzp1/MtxaR9+wmp+Y/iny
 Q/ZkKNhzthwfpeQHHXC7q7F/tlnN2m6vKHHb/WiJkB0ziNNWteEDl5fyBbhBUnZWzxy8
 Q/dwX0p1jhFMtKMYxkhWWIjCNZqxVlxkZFvAJSFOK+jsNSo4hPd2m6I1z5gX5zIMzjhl
 2shHYpHqJ+BDUANrJ21lzglYr0qLlUPjihNvynK3z4sqtPxvyIFPjOVIK5coHywipfO+
 8oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702355972; x=1702960772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7kKjpYgRbPhgH5U+ZaCrjOh/6654v55c2tM22nE+pfo=;
 b=vSxrPdh99gIbra+ZGPiWFWG9nWxApWrJZcALyxqdJgM5IWfv+Oxcwt+SM7TzzdzSDt
 0kb2EPHs21lpe4v7dVc1uB5diNX2Tv+GIG4YJbBgMYibDzfgJYeSiaFJ02U2z9JtvRkF
 qfCow6k7MwbD0NT+5HfJ84QLuiucOTQ6u9Y0Krqn3MbTjh7t1o3BbSM9ZbyR1b/XRcfB
 fgC+ohthhVaebXPT+WH4wW3C0OtIrhiCR0n1rhaTqWxjRaVoMi8DKnITFToKlpKJsJ1+
 hp7v3TczIRssdA7FpnFea7exSoGh43DcY2sjtfaj0907KprdgklvDuYULBu4YfLjVDmz
 Nrkw==
X-Gm-Message-State: AOJu0YxCKbzB0GSoHgR5HDzBfD0Q4eX72Ntx6R1VIoJvtg5UzbZOm90i
 8+UrngpLQ7jRTYMw2GM4zDM=
X-Google-Smtp-Source: AGHT+IGMY3Om+qfmZNjoV8ZR6yUKkT4JVIHCdNzmI58O97xTxK9UQ+1yJhZgnORDlRYMbYJtcEV2Ow==
X-Received: by 2002:a05:6808:128b:b0:3b9:dd58:d9d8 with SMTP id
 a11-20020a056808128b00b003b9dd58d9d8mr7490271oiw.27.1702355972633; 
 Mon, 11 Dec 2023 20:39:32 -0800 (PST)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a656854000000b005b7dd356f75sm6206291pgt.32.2023.12.11.20.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 20:39:31 -0800 (PST)
Message-ID: <33544b27-ef02-4270-a35e-9e1149bb2e71@gmail.com>
Date: Tue, 12 Dec 2023 13:39:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/qtest: Add tests for Zoned UFS
Content-Language: ko
To: daejun7.park@samsung.com, "thuth@redhat.com" <thuth@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Jeuk Kim
 <jeuk20.kim@samsung.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Seokhwan Kim <sukka.kim@samsung.com>,
 Yonggil Song <yonggil.song@samsung.com>, JinHwan Park <jh.i.park@samsung.com>
References: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
 <CGME20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p7>
 <20231208062200epcms2p7de0f3ab428a85eff0280225dbd1b1f37@epcms2p7>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20231208062200epcms2p7de0f3ab428a85eff0280225dbd1b1f37@epcms2p7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


On 12/8/2023 3:22 PM, Daejun Park wrote:
> This patch includes the following tests
>    Test VPD page and report zones
>    Test write and unaligned write error
>
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>



