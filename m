Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80484824153
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 13:11:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLMYz-0001M2-9D; Thu, 04 Jan 2024 07:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rLMYk-0001A2-4y
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:10:51 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rLMYg-0001jM-Qa
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 07:10:49 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d3eae5c1d7so2631935ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 04:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1704370243; x=1704975043;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q23i9yT7yrVEFxnf3fk5D4MyK0KHTuKJKDM3rop1kno=;
 b=B+Ew/aIUys7urTfHZqyRqvVB0fUgsulIiWk4R3RozZHK0jdBqhyyq4SCqIkH6cG1bQ
 fQegw97LmZ6JapHG3NVzY9G7uIdEJgHJgAR0DEsKvYmVnVxMLC4fD+s9E3kf8fKuY4HT
 /lpkp3W1DWO34mAXk9RxajieiJOr6tewFI0D3OkmcSrLsPBf0TJtqYn3sh1VIGWxxGFf
 7JK6khaV8aieoCR8nN8ShwcUUmNszHhsNlIfzjHgRPlYVDqqypOlEWXrrCxrk8ymPgfc
 SwLESZ5vc9biCWB/AyLmHoSNaxcLgqQEChTkDWn9AcGlg5PKv4df0JKGhb1lWrcB1HYc
 ITSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704370243; x=1704975043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q23i9yT7yrVEFxnf3fk5D4MyK0KHTuKJKDM3rop1kno=;
 b=JIxfthuTGHaQavBQrQIrASANDDH+RiPuXejsaZfmXJjCZFOy8831PmuQW3Y+KvZk+m
 bnkSpeZisRqYqqOigwldLi1IicKPx9zKSl/cXpvf4yIkLSnv3WduUnJZJEWh6WfLQxD9
 Lwvud50unRH68te5mNFiIc7o7aw9B9+5tNJOCcJOTgKgHcAMSHKAa9nAy62NcgzVa9dJ
 MNPeobvxt9+TIBKgx50i2Km+Z8IFeE94khV+1RZgxZrT/nTmrNLSDxCmcIR8EJ/4wl9R
 /GJ4Dhy+YLDcAvbNK1GzostVpCzed7RprEXyVVv6flBkT808D3Puj9VZ2VDn5cK3QSC9
 HCEA==
X-Gm-Message-State: AOJu0YzQL2XuRNTSKORVEzXdprM8dHQJKsHn0Yp3glbcWd8io4WH/wS2
 ak4bNnRnfJ6/oN4PQL6mBiH8U7ZNIjp3sg==
X-Google-Smtp-Source: AGHT+IEvVniyWW6+pm7fNDiUCukxNFVRQmngQJsY2M7PnvRddXZwN4RLgEaC/QIRqiAw2JDtmofBpQ==
X-Received: by 2002:a17:903:1d1:b0:1d4:2b5a:9cb7 with SMTP id
 e17-20020a17090301d100b001d42b5a9cb7mr365235plh.47.1704370243101; 
 Thu, 04 Jan 2024 04:10:43 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 x22-20020a170902821600b001cfc1b931a9sm25324308pln.249.2024.01.04.04.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 04:10:42 -0800 (PST)
Message-ID: <480302ec-4fb2-4e97-8940-8ec27846efc5@daynix.com>
Date: Thu, 4 Jan 2024 21:10:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Make Big QEMU Lock naming consistent
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-riscv@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, Fam Zheng <fam@euphon.net>,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>, John Snow <jsnow@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Jiri Slaby <jslaby@suse.cz>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>,
 Paul Durrant <paul@xen.org>, Jagannathan Raman <jag.raman@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 xen-devel@lists.xenproject.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Kevin Wolf <kwolf@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Eric Farman <farman@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240102153529.486531-1-stefanha@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240102153529.486531-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/01/03 0:35, Stefan Hajnoczi wrote:
> v3:
> - Rebase
> - Define bql_lock() macro on a single line [Akihiko Odaki]
> v2:
> - Rename APIs bql_*() [PeterX]
> - Spell out "Big QEMU Lock (BQL)" in doc comments [PeterX]
> - Rename "iolock" variables in hw/remote/mpqemu-link.c [Harsh]
> - Fix bql_auto_lock() indentation in Patch 2 [Ilya]
> - "with BQL taken" -> "with the BQL taken" [Philippe]
> - "under BQL" -> "under the BQL" [Philippe]
> 
> The Big QEMU Lock ("BQL") has two other names: "iothread lock" and "QEMU global
> mutex". The term "iothread lock" is easily confused with the unrelated --object
> iothread (iothread.c).
> 
> This series updates the code and documentation to consistently use "BQL". This
> makes the code easier to understand.

For the whole series,
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Thank you for sorting this out.

