Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E97727824AD
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:41:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzTp-0000lY-Aj; Mon, 21 Aug 2023 03:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSe-0008Lw-OA
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eesposit@redhat.com>)
 id 1qXzSc-00067C-2Y
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692603384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j17MvYFWCAhJSWaN961rMuVj+cD6ONIKgHhlISOQBr4=;
 b=Us9DaG4h/4bZwDTWIoGGnLI0Hw94fWwy1ckub8Je3mpcWwx02LtyEa/VicWdHgN2PmuJ6a
 9Ub6tpHEcmamfdWAsvpOJZKycBkz3ZYX+sCzrsUsnTWvmTL4lLMJenO362HFqeYJ8Jmzbq
 iMGXLjjFQTkNG3cvXqKp5eMRqK/MwNk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-bCLtNz9IPKmcxvpoiByKjg-1; Mon, 21 Aug 2023 03:35:16 -0400
X-MC-Unique: bCLtNz9IPKmcxvpoiByKjg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe5c898715so19822065e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692603315; x=1693208115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j17MvYFWCAhJSWaN961rMuVj+cD6ONIKgHhlISOQBr4=;
 b=JmYbNtZAH5KhfE1f/pQstDi62p6vaiLoThI/YRqKFlSIPhicBHtxQdscs9UwYt06DC
 iYDk8zcWxKScLS+dCvHgyAdO19wdm9bekCS7X40xOD6Ba2+dkxzxYaXh21Tn/v/S69c7
 p+hETYklw+3n2iZVJX+4K1931jUiSUu8lxGBAVZ1AV2Wd7qssCCuQ9bRxudASuDcfF5M
 wG578MgsyM6iOCEGl0/ToUhDphfU4RSPbh8pHK0otiwlxmR7+dO7CbgsGt+dE/yqRlhr
 /1cZBwoz/VuAuP/M/3fbOVkigswDmuKOPuz4kjxcWXV41dVG1OLutJO8CHx6zxdY6kfW
 rX7A==
X-Gm-Message-State: AOJu0YwE3nKCGtL+3EeMnhiKguXyo+AMqIPkJfPmtH/vpzPVSFqMw8lQ
 4DmfOR6T/6ql34QGYx6Kaalka4Rcx9PoZ1ERwseVnwhz5bnbTng3QO/ghIIhSUedzbeT3m4iysF
 F5xE/gBxmOZFjIW0=
X-Received: by 2002:a05:600c:d8:b0:3fe:e812:4709 with SMTP id
 u24-20020a05600c00d800b003fee8124709mr3267866wmm.12.1692603315511; 
 Mon, 21 Aug 2023 00:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl8rW+nup6UYGbQad8Nl5t04aR5vMJ1yMxDCRSOQPQh9p2KwEQuMbsJm7ILXBrziG+WZZhdQ==
X-Received: by 2002:a05:600c:d8:b0:3fe:e812:4709 with SMTP id
 u24-20020a05600c00d800b003fee8124709mr3267864wmm.12.1692603315365; 
 Mon, 21 Aug 2023 00:35:15 -0700 (PDT)
Received: from [192.168.149.106]
 (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a1cf203000000b003fe17901fcdsm15152344wmc.32.2023.08.21.00.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:35:15 -0700 (PDT)
Message-ID: <7ea2488b-4c1a-b822-6539-20f8e58d55a4@redhat.com>
Date: Mon, 21 Aug 2023 09:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 13/21] block: Mark bdrv_parent_perms_conflict() and
 callers GRAPH_RDLOCK
Content-Language: de-CH
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com,
 vsementsov@yandex-team.ru, qemu-devel@nongnu.org
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-14-kwolf@redhat.com>
From: Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <20230817125020.208339-14-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eesposit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.279, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 17/08/2023 um 14:50 schrieb Kevin Wolf:
> The function reads the parents list, so it needs to hold the graph lock.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>


