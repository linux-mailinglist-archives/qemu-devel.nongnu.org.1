Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6B80CAA6
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:18:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCgAm-0003jh-Eu; Mon, 11 Dec 2023 08:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rCgAg-0003Yy-UV
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:18:06 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rCgAe-00084V-Em
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:18:06 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d05199f34dso25326845ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702300683; x=1702905483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jPFB7546KXe2m1ok9T4Lz33ts9EohmOcjKURgGCjvng=;
 b=emQ9RCaC7pp540WjXb+p2ePc7lLK/7YWqPhSDzX2UmYp9EIpYUjZTQQj0+tyD/x2WI
 OCg/hzf8pOMdS1nOKKmyzwlVPcg54fxmPKPh9CKu4M/TCBqt54uqOy6u2c6/+TyReoYl
 FTQ79lH75dFHOurZ6GjJpB0DNFcbukRvg0qdsjr/QzrSDKYF4zE23/hQwKSIma1i7Etk
 UTCRiTiu87MQj82HaFQoLFCOe1sYbmI8OUtdrIvTDEcqVDuBNXP653qSQ+wINooVB7+6
 jFaZJGomEajMC66QJBIJYGSv3/4hsz31bQuCEFq+BMAfGza8cdu7IuM4rot8QAEylT6Q
 WsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702300683; x=1702905483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPFB7546KXe2m1ok9T4Lz33ts9EohmOcjKURgGCjvng=;
 b=RwJuFemVA9xHT/1mA7WKYB+Uz0RfntkV0rNfTTwzXMS+JP1hzlji6u6vwxPez6n731
 stbEuV8ey/Q5AKJ98Qe7hwdmfkMxWIpsK7HR+vJZyun/wnqrq5WMKW00SR+QhsB6RO8y
 hsHlGYij5d6uUw9+iTMfno8Y9NdIuZBxAx7C1y0hoC0fFntaSiZ855sDlat2k4rGvX9Z
 WbIo0RlwmSYnDEdKbOvp5Kg0wtQxM48H823KE4mllVNuAz/90ZzPqEZOkAC9ebn8jQ4Y
 9LiOwkSVez+ySx45ic07TDBIgkF9An/XvnGeVXCc1aC6wBHmJUt+tA2zB7P5F6O3UUVt
 1Rnw==
X-Gm-Message-State: AOJu0Yz7dBYKw6h6x8v6iUcNdawxUxRenkmfnroS+hc5TLhcnrB6mEgx
 I/tRsubTjGAqvWJWiovy2iA=
X-Google-Smtp-Source: AGHT+IFGm/eLX8KASQs4Mq2dmYaS079RJAZAoWCRt6rB4xJxic3x07NKsC6t7PHLiHhfM/0I/7GVzA==
X-Received: by 2002:a17:902:b686:b0:1d0:b6d1:d464 with SMTP id
 c6-20020a170902b68600b001d0b6d1d464mr1890533pls.78.1702300682688; 
 Mon, 11 Dec 2023 05:18:02 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ec8400b001d04d730687sm6560531plg.103.2023.12.11.05.18.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:18:02 -0800 (PST)
Message-ID: <fec39bc7-f02c-400e-a10e-b069a99e5b24@gmail.com>
Date: Mon, 11 Dec 2023 22:17:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] virtio-net: Added property to load eBPF RSS with
 fds.
Content-Language: en-US
To: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com,
 mst@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 berrange@redhat.com
Cc: yuri.benditovich@daynix.com, yan@daynix.com
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-4-andrew@daynix.com>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230831065140.496485-4-andrew@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x635.google.com
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

On 2023/08/31 15:51, Andrew Melnychenko wrote:
> eBPF RSS program and maps may now be passed during initialization.
> Initially was implemented for libvirt to launch qemu without permissions,
> and initialized eBPF program through the helper.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

You may use DEFINE_PROP_ARRAY(); it allows to specify the property with 
an array when using JSON. See also:
https://gitlab.com/qemu-project/qemu/-/commit/b06f8b500da2a5a73dfb15de17cd96ad2385fdc7

