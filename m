Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B39382C8E9
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 02:52:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOTAa-0004rJ-Kh; Fri, 12 Jan 2024 20:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ved@rivosinc.com>) id 1rORtM-0000aR-VP
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 19:28:53 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ved@rivosinc.com>) id 1rORtK-0007uc-CQ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 19:28:52 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d3ef33e68dso49744595ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705105728; x=1705710528;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gsm5BgPC3U8+ci61AhiTIOfIfHAz9Z+LUC5yPUBYy64=;
 b=N3svVKm2lCquU1V8aqZh9lFkCSKW7kWIEdrw1GMO5+n5hErCN3uorF98VzKvr7Oxvj
 Jj3kc1/DlX1ihQ4Me83YwKHY7Ram8Lz2fP5kjNrmTvVZUn+PTiJty+qjHQ1YBu0ANgRN
 C0P2tfXF+6tenDYcu0dmI6PUSgN6XIduz8WqCYXJGxjOaQavXZF6Ip/xWUWU/rMOiO/0
 syQLt4BAWW+5mFSzrs43GOX4meOsMSm/d89G0U1/Ay9G39TUbEu6P7drVgjfDmWbYcmY
 R5hBhD2h3ACa6ivR+AklyYVjskHo8FPtvDutf+Ov1Q3rZzteo5Yj+XEA38NZsLNQv5tk
 d+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705105728; x=1705710528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsm5BgPC3U8+ci61AhiTIOfIfHAz9Z+LUC5yPUBYy64=;
 b=htNq1exLtU4OJPXDO3ng55YDwTtY8U4mib+CYejemi0XjSOoUFEMUXuUnbrQp+/Q2d
 lLAewkaY3q7PximHsTGQejQlpBNoah01SN5cxCdOlcr6ObaiFAbZGJLniHFZyLNxLwYi
 74Tf2zISxlcQImSis+IpgKyO877WmzcTeVBzUJQc0uxJH6RVjyzAcPxOUT3r2E6pGb+6
 hnjnS4Gq4ozt9WswypK3nVz/z/mTcGLyaC1rqbmnaWJgwaxQeLQnVIwf9ch26KFR9Upn
 GWZpe5Iv4ZYldG1dzuYkqzhkhKQWF1TN3IhDVbePQqlMPxDvdQ+jEbkMXUE0K18grZqp
 wMOA==
X-Gm-Message-State: AOJu0YyRwfifPJUGnuw9OrnwbDCOB/DCgcpZCbP1EGQzD8pTlZZgaCxp
 Z7TKE9Ph6OT4K8qEfl8xua4ZPELHS9HkBA==
X-Google-Smtp-Source: AGHT+IHEZ/JKocSP/JgiVDfECSziL6wGFKozxONVH2rZIbtbNS6rSer91mSpTk7dqE3D9RwNIuS0Qw==
X-Received: by 2002:a17:902:bc4c:b0:1d5:73d0:eb7d with SMTP id
 t12-20020a170902bc4c00b001d573d0eb7dmr2497346plz.18.1705105728288; 
 Fri, 12 Jan 2024 16:28:48 -0800 (PST)
Received: from ved-XPS-8940 ([12.0.166.162]) by smtp.gmail.com with ESMTPSA id
 sm9-20020a17090b2e4900b0028bad9b220fsm4842111pjb.37.2024.01.12.16.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 16:28:47 -0800 (PST)
Date: Fri, 12 Jan 2024 18:28:45 -0600
From: Ved Shanbhogue <ved@rivosinc.com>
To: Rob Bradford <rbradford@rivosinc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: Re: Re: [PATCH 1/3] target/riscv: Add infrastructure for 'B'
 MISA extension
Message-ID: <ZaHZPZauuZh4SwVj@ved-XPS-8940>
References: <20240109171848.32237-1-rbradford@rivosinc.com>
 <20240109171848.32237-2-rbradford@rivosinc.com>
 <20240111-585fe1291fcaa1e0432674e3@orel>
 <20240111-df7a6acf3109b630469591a1@orel>
 <3dbd3fa1cbad80948175f98dcc0c76b886e2376e.camel@rivosinc.com>
 <20240112-d9e3cc215a7a68c5189908bf@orel>
 <7461190fbece351f916eccd258bf62b86227927d.camel@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7461190fbece351f916eccd258bf62b86227927d.camel@rivosinc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ved@rivosinc.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Jan 2024 20:50:28 -0500
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

Rob Bradford wrote:
>I'm using table 27.1 in the published PDF which is the PDF in this
>release:
>https://github.com/riscv/riscv-isa-manual/releases/tag/Ratified-IMAFDQC
>It looks like it was removed in this commit (which is a set of
>backports):
>

We would retain the previously documented canonical order with B
between C and P and that table updated on ratification.

regards
ved

