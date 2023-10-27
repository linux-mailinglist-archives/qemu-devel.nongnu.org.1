Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966E7D9073
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHj9-0006k9-3t; Fri, 27 Oct 2023 03:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwHj7-0006iZ-NQ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:57:53 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwHj6-0000Ti-AQ
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:57:53 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5b92b852442so1215451a12.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698393471; x=1698998271;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qsx6BMk+2xEBbyimCZsuizMAUkGirkJbhbs/cJk68mg=;
 b=EUFyyrxmrxh+mm5slkiiaxklq0/LlF3rgttgJHl3WlGzp0SbrhnJqBx6oUTvEvDmMq
 +UeTSGps/pFVd+3Ux1+P1TCeTiSalsFEVpzfq+GqyE1gAuZWa+cWzBNhTCnz3gglkOYL
 aKM/reVwWHi9QSv/76/f9qQ6CK6eaL7aZ62yKlkIfPSkfyijrDD/GD/qWKc3j6C/73eH
 Z+kgwmOkLGyB2Fu6UpDEi7bk7tG/rEf1ty6Xd52r1JvwIB6JKUX21NsAuCFC1LfjObhM
 Wl/BSi8Ddjs0jhgC9LDWlMORyF9Mtd2h3HblNTbCgPpfuDbg8q8POo/RUf/PnVH2shkY
 JUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698393471; x=1698998271;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qsx6BMk+2xEBbyimCZsuizMAUkGirkJbhbs/cJk68mg=;
 b=QaGFhnP8OtiHgHglU1SWPd5c7Z6bRqtIDkxboAQnpidn5hUyZKlrCql0Rn6t6xeaKV
 3wXMszERb9tJqtmXgQMxX6wmcj/aZh8qH+ducvCMFcNkBxwTerJQw0T3J7Kn2hSCo72D
 ASOasoyvJ8tYytqtWQwAMzJQ5otkSH9hBANhENmKRHS1cNLTfJqneWMX+l1eI7RwOhoE
 D4yW9HYxqJGJCNlA4mdTqomy1hv/zhl4SIhsaPcdQDzLBBZ/zlMrSZSEXacPhXZcZakl
 79BLu3ytw/k4g9ijWkpl9Rg4JfjAOkL2M7N6e9R98WZaRO2VV/IAgUdgLlnzYcyuPnK1
 CtJw==
X-Gm-Message-State: AOJu0Yxlqc6shS6K/c9vqiuGb7rlZhgO2TpA4/Lq+pYC1nvXBGkVEFpx
 LruuWXazkUtgCVGgpBbGSNCGcA==
X-Google-Smtp-Source: AGHT+IHO8lyYms8BkgQiBTEcfbbA5r5F0L6dISyIylIgISZC2QmcULlueyP3t1+RbuqsSWDCU/83GQ==
X-Received: by 2002:a05:6a21:3290:b0:17b:129b:1817 with SMTP id
 yt16-20020a056a21329000b0017b129b1817mr2619171pzb.45.1698393470744; 
 Fri, 27 Oct 2023 00:57:50 -0700 (PDT)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a62cd05000000b006926d199fdcsm814805pfg.190.2023.10.27.00.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:57:50 -0700 (PDT)
Message-ID: <04f5ab84-b0d9-4f1b-8433-21f94f10f0d7@daynix.com>
Date: Fri, 27 Oct 2023 16:57:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/21] virtio-net: Always set populate_hash
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-13-akihiko.odaki@daynix.com>
 <CACGkMEsKUnB8JhvCzsJ67==Jq=+S=xCFttXoaZsOd++4sBc-Uw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEsKUnB8JhvCzsJ67==Jq=+S=xCFttXoaZsOd++4sBc-Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2023/10/27 16:08, Jason Wang wrote:
> On Tue, Oct 17, 2023 at 12:10 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> The member is not cleared during reset so may have a stale value.
> 
> Nit: I guess it should be "always unset populate_hash"?

I meant populate_hash should be always set to either of true or false in 
virtio_net_set_mrg_rx_bufs(), but I agree it's confusing.

Regards,
Akihiko Odaki

