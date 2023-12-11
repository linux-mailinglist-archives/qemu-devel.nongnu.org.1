Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCE80CD4F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 15:09:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgwq-0005nJ-4U; Mon, 11 Dec 2023 09:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rCgwm-0005n4-TQ
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:07:49 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rCgwl-0000d8-83
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:07:48 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d0bb7ff86cso40662745ad.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 06:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702303666; x=1702908466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HbikGgeXPXXROHrMpXMsGbkFOHf6Nao8HMqyN+r+WD4=;
 b=fRoDMMkpl1yJi8GfqWECmMs9KUhlsi9xIpfF40GmvjFpgrhyzZSYQXK65OXOkFt2Jp
 SAVOheYUU9I32eXWc3Rf6+wWqxAu3gF543mtiPBRqJsA8XFSRBAb9SYWgonAtXkUdku2
 J2AZp5QQlNxBm0Lkdrp77M4FKM6L0vEYWnqhocQdUa3xet3746mxABVtRWVAC9U49IPR
 ZbZ+Z7lJD38/C4nvfCJRJN3X8dskAqSvbdNOpGHkChMGaXpG6uGv/4cGqcSNjZcLP0Ia
 T7XZA1922A4hKxXXRyu0lgbLTOVrVjo0Wx21F8vSou7DmWntDR9G1BL3Z4BpjYf7P8qA
 6OhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702303666; x=1702908466;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HbikGgeXPXXROHrMpXMsGbkFOHf6Nao8HMqyN+r+WD4=;
 b=psxKvrm7IfBrmjRE3eqVcfmIss2qWQenrtsUam8zehFLU7P/rXpb7yMSUCsfP6YCi4
 Od+duIHHJLmmxXznvgs2HKIF7TMdnCW1d7rFbLS2h+/BplkkVeMkGL0+BNUYYPKRx58c
 TPe3nSPtiRSAe7eatKm5TtIZDZNtPpGMtQ+VWPjL4VNZlFdmcJaAA2NdcPsVP2dSsynk
 LiBFw/DW0RaIANryWJuAKsN6NfiXAciU/NeiYQ2eLfX4A+9TeG7RaQrb74/Yg08Q4c6U
 d8Cs4MoVaquNZXk8cTq+FKYUcxeyaYZMHPYVHdYdo4WJu4YiXOhJJPRzGR3ZmYak+eAa
 gO/A==
X-Gm-Message-State: AOJu0YwiG/S2IFqrtC8IhaiTmlxDrkGP6svpL9AIiJcMtMnTkxE1yUWx
 CVRTbA1ZCHL1TR/02nOOZR8=
X-Google-Smtp-Source: AGHT+IEJfmi3Qa6LOk8Dzws+eJi93onkY8A+3MM1+4sIgwFXsUZsJtZx2uik8q8cOct9eYtwpgeF7w==
X-Received: by 2002:a17:902:f550:b0:1cf:e19e:2509 with SMTP id
 h16-20020a170902f55000b001cfe19e2509mr4749062plf.25.1702303665638; 
 Mon, 11 Dec 2023 06:07:45 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a170902d48700b001d0c1281ef5sm6654844plg.89.2023.12.11.06.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 06:07:45 -0800 (PST)
Message-ID: <47d40dd5-3a75-4f54-91b7-2f9b073597fe@gmail.com>
Date: Mon, 11 Dec 2023 23:07:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] ebpf: Added eBPF map update through mmap.
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>, jasowang@redhat.com,
 Andrew Melnychenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com, yan@daynix.com
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-2-andrew@daynix.com>
 <46697e3b-3ec4-4635-97d5-39919068d709@gmail.com>
 <CAOEp5Od+_KHm86L7PLVo22KqLZuBc4dWjh0=4iAvT_zyhSRLMw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <CAOEp5Od+_KHm86L7PLVo22KqLZuBc4dWjh0=4iAvT_zyhSRLMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 2023/12/11 22:48, Yuri Benditovich wrote:
> Akihiko,
> This series was already discussed several months ago.
> I'd suggest to postpone commenting on it and resume them after merging.

I found a pull request:
https://lore.kernel.org/all/20230908064507.14596-14-jasowang@redhat.com/

Strangely patches from that series seem missed although earlier patches 
are on the tree. Jason, can you tell what's going on?

In any case, I wrote comments to the patch series. Andrew, can you check 
them? They are mostly nitpicks, but I think you may have a look at 
DEFINE_PROP_ARRAY(); it may make it easier to implement the libvirt side.

I also forgot to say that properties should not have underscores; 
ebpf_rss_fds should be ebpf-rss-fds. See:
https://gitlab.com/qemu-project/qemu/-/blob/master/include/qom/object.h?ref_type=heads#L1013

The series needs to be rebased too, but probably it's better off to wait 
Jason to figure out the current situation of the series. Once it gets 
all sorted out, I'll rebase my series on top of it and ask for review.

Regards,
Akihiko Odaki

