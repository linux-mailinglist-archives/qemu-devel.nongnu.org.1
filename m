Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7837DCC6C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:56:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxnLG-0006WZ-3y; Tue, 31 Oct 2023 07:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxnL0-0006UZ-8o
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxnKv-0008JV-Dp
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698753307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNDyl2aHaNYxiZuRoBCjY7hYuQgAuvWvLWJd2rLrsc0=;
 b=N8/MXdeFnvdaMimyl9D1K49SR4lj63SZ9L78eE6c7hyQL0ldqHbMe5blHQKokZtJZtkpJ4
 ZyJlVGg2+OJeMXFaz2uITQFzhwhHv2TceckMyBg8aiwKbVOp0JyJDaHyV4MkW9o0NQMntq
 v/wUqFHE2NwgReu3l7uuPvqWyOc9w6c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-q_0jr2eGNDeMxvGVp1ibNA-1; Tue, 31 Oct 2023 07:55:06 -0400
X-MC-Unique: q_0jr2eGNDeMxvGVp1ibNA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so41461135e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 04:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698753304; x=1699358104;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WNDyl2aHaNYxiZuRoBCjY7hYuQgAuvWvLWJd2rLrsc0=;
 b=vX1khMh3TZ62mfICB+plkLOa+o89+Xtzx191t9sLxxsQKTUpQyl0rk2n3CkyB+oRmG
 NpbO0/Bu8zxvyB0aema37TEWOeZ5/s7ThK4jvXtqr0KsvW4Mf8dXa2xRwjnTypLMOO48
 CwfzepplzQr1CRg8YFSianHO2+YEqkf3yYPkxLTnknuGeXvR+aOyrikpfjps/jlbjXRA
 F2DsU9dPFV50AedcmAjh5w1K9KJeJqlCaAbsz09MM2HHR8gGzXVHRtZr81gjHPQb7k/3
 PNQJO2ikBbnizkfC2RsIW85JXU1NMIAHO0++2wSkUURKx4B6dlkuv4Way28clkWmTAuS
 xEfg==
X-Gm-Message-State: AOJu0YxOgZzDWiLiJw6sG3rTq+bm9qK4+tC+yY1fYgayOdWzbyMDLqYN
 lI4nUnUXHNVE0XTPKOiwSAFx1+qGCn7kzA7wKBSWtOG0Z8hT8yXurE8lYsmTMAH/kTpRwKvCR6s
 +WcxGOZ8NU1QoNQdsX6KJPZY=
X-Received: by 2002:a05:600c:548e:b0:408:fe93:a2f7 with SMTP id
 iv14-20020a05600c548e00b00408fe93a2f7mr10459654wmb.37.1698753304603; 
 Tue, 31 Oct 2023 04:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA5PBw5lZLbzp/RcJvYk5n4O879gDpzYkhuMdMrQARgepC58ro4ZalZ4zmJl6v8WLvMBIiqg==
X-Received: by 2002:a05:600c:548e:b0:408:fe93:a2f7 with SMTP id
 iv14-20020a05600c548e00b00408fe93a2f7mr10459643wmb.37.1698753304332; 
 Tue, 31 Oct 2023 04:55:04 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a05600c310c00b003fe1fe56202sm1540446wmo.33.2023.10.31.04.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 04:55:03 -0700 (PDT)
Message-ID: <f5209ab8-6868-47f6-89b0-023e41406680@redhat.com>
Date: Tue, 31 Oct 2023 12:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iotests: Test media change with iothreads
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org
References: <20231013153302.39234-1-kwolf@redhat.com>
 <20231013153302.39234-3-kwolf@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231013153302.39234-3-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13.10.23 17:33, Kevin Wolf wrote:
> iotests case 118 already tests all relevant operations for media change
> with multiple devices, however never with iothreads. This changes the
> test so that the virtio-scsi tests run with an iothread.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/118 | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


