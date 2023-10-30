Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 788EE7DB260
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 05:01:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJRX-0002Iy-7v; Sun, 29 Oct 2023 23:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxJRT-0002Io-69
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:59:55 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxJRR-0003Y6-Iy
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:59:54 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c77449a6daso34423665ad.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 20:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698638391; x=1699243191;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2OmTN/rwhEO0MzoAwEtR0t97SvbFQ/gPN6ii+3CRucA=;
 b=G3fjm+Y60VcCPNKoilYeal2VWvVVKfrI+ju5TgH03oVjpi6ntBJKp8y0UFVtPRksoN
 AGEbwMK2fgKvhMUo9yy0rEOsCg36cDvkkElrOdU3od2fWjVqRIoP/JK5AMcQnkU5qQ9i
 ir/lqeqDjfkURqXqVSr9v6f4HeOsDz625lz8RLnuZk3GHXM5mjnr4426VzfVgl+RYIwm
 rWAccjF9PYrXR3NVyl8Eo3XtW1XuJ2PYIlPjjFDvW/0O0PvCz1i49ivN7ieLhu0xZAmg
 5cKcCmiKsOWhkJ/Xti+oz9A6e16pEHTA+C8wBcwrEVdWWqDN9Dv3h3b5ftnswAJ26XJg
 w+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698638391; x=1699243191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2OmTN/rwhEO0MzoAwEtR0t97SvbFQ/gPN6ii+3CRucA=;
 b=RkFhP6FnhLAA+7WUYtpqKiGRbiRe6SkCmP/HYDJPU0xqVxqEUpF4NqOeZVTC0tuc6C
 WR+qnB5NiWCk+jRMRUXhgWWTxh3BaB19cwniWFCFGMVXRo45NhtxuOSkU5Z343c/Pqa3
 iQ6E6fk0cMJqj4/st8yQsWAMyfSuXpUdj8Gb2l1KJcp6DUS2tFcwpuSO/CR4drSqo7pE
 STGuNc3B7CCivirTJf8tpWGTb0QMQOAFFXg5RQFe+zUYlCdJ+2bAMyNCLjRHh2lGPyoL
 zMK5iWNh6ijjsyqmnAmUWceApQgp8/kkeYo2LZ29Xr+cf0mrdYT5HdzxtoslgWPDdaod
 Dn1A==
X-Gm-Message-State: AOJu0Yy8e3avYLk57t3T4DYAQ7cUN5+1AduBlHUVD0R7ZR/aquVxPku1
 +sz4/90RIAAZU2qLAMLkNVXSkw==
X-Google-Smtp-Source: AGHT+IHpX+BUMosGKYBGUHnTSp4/k92hc4mGq3i5E25KtU9FKNiQaM/HnU4Wo+CE4P8eGSL2WKfbeA==
X-Received: by 2002:a17:902:d28b:b0:1ca:e491:f525 with SMTP id
 t11-20020a170902d28b00b001cae491f525mr8348456plc.31.1698638390672; 
 Sun, 29 Oct 2023 20:59:50 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jo8-20020a170903054800b001bd28b9c3ddsm5200642plb.299.2023.10.29.20.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 20:59:50 -0700 (PDT)
Message-ID: <0c5ea17e-07f0-4bb1-b1ff-64a5747a9193@daynix.com>
Date: Mon, 30 Oct 2023 12:59:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/21] virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-16-akihiko.odaki@daynix.com>
 <CACGkMEuA5azGUQzyCe=4xq+YfV60PuiOajhJ=1HOXoG9Gege5g@mail.gmail.com>
 <8247b828-fc57-4f40-8320-a1e2c494f216@daynix.com>
 <CAOEp5OfYZ3W867iXXEu70Za_UnxdW8UBW4qV-FjBZ=R5nFNUeg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5OfYZ3W867iXXEu70Za_UnxdW8UBW4qV-FjBZ=R5nFNUeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2023/10/30 6:56, Yuri Benditovich wrote:
> This patch allows  VIRTIO_NET_F_HASH_REPORT feature to the adapter whose 
> backend does not have a virtio header and does not have offload features 
> that depend on it.
> The migration between such different systems is very problematic even if 
> it seems successful, such setups are not performance-oriented and 
> especially supporting the hash delivery for them is (IMHO) redundant, it 
> just requires more testing and does not bring any advantage.

Whether the peer has virtio headers or not is irrelevant if 
VIRTIO_NET_F_HASH_REPORT is offloaded or not. Currently QEMU always 
implements hash reporting by itself and does not offload at all.

