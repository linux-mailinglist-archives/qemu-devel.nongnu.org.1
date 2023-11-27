Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 527557F96C6
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:23:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PP8-0005lF-Nq; Sun, 26 Nov 2023 19:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PP6-0005kn-HW
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:23:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PP5-00007N-4w
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701044590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s/5hhuo3PbLrdJBGlLY57GFAX7PwJW1kv2rTLImRgnE=;
 b=Q39OZemCCotcl1sVulIufDXH0kj+gKbgfgitZCuVwJXerZadMQx6oig8f9hSOEtRdDxhGd
 85blPjahDuMqqumnVmRPwILfJEl7lOtCzg7V3DcqtxVsVF1pRvYn/4ACyXiBAn7oNzV6bQ
 tz5FNZ2ym4XHA9UR0N4/q+IgWlcyDNw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-0PCg48FYNXut9Bj0m5NGbw-1; Sun, 26 Nov 2023 19:23:09 -0500
X-MC-Unique: 0PCg48FYNXut9Bj0m5NGbw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-285d0ef1056so612953a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701044588; x=1701649388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s/5hhuo3PbLrdJBGlLY57GFAX7PwJW1kv2rTLImRgnE=;
 b=QTLz46A8FfZBf9c1T59g20l0ZVUx9yrwIBOiqIHNqFERbkIWCEbGt9Ri4oPNk+OmHm
 1OX6l0YiOCc7MBcv/W01Ek4oL0Qmr3M8oQ7j9ADgSgQyCnDltSiFoCeLpX3AFrGyLM06
 EpPoIzNRwadcaEi727YlZKSktKF9OaMxhgFS5FtYuhp1gTPhWNkjFi8mehAljGmybi8z
 p1FBaW2V4uAOXSdWoBOKejdtMjumKO/ptvPgYAHpO2gEz/o7QyGIVBlqtNe9KfJDR2JL
 CPRCPLGlRIp/47Pt7joVb9xWBCdOmm+vcd1ohLcHHAYqLebwGldF9x1XJFWSqKKcdpVI
 HXyA==
X-Gm-Message-State: AOJu0YyotXohyHyih2SKn3AJAuXbDoHrimz3fwTJ9eBJzDTmbn8bzrDl
 JssznbstyHlky8wFh7F+fY+6oTLXMznPzTHUpxsZvYLzeFEEXfJR6vmVx5cI6whc2GNJgYxKROw
 Kgl7H2zfby6G3Hqo=
X-Received: by 2002:a17:90b:1c83:b0:27d:549b:3e65 with SMTP id
 oo3-20020a17090b1c8300b0027d549b3e65mr10237640pjb.49.1701044588148; 
 Sun, 26 Nov 2023 16:23:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmHmKibTTfeLcjnRWH3CCGuYdIeylfXDL/TqcLBiOpkpYdR4PGXpEfCK2mIEOp9Tq2QtA7Sw==
X-Received: by 2002:a17:90b:1c83:b0:27d:549b:3e65 with SMTP id
 oo3-20020a17090b1c8300b0027d549b3e65mr10237632pjb.49.1701044587907; 
 Sun, 26 Nov 2023 16:23:07 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 ob14-20020a17090b390e00b00285a17f9da1sm2901511pjb.43.2023.11.26.16.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:23:07 -0800 (PST)
Message-ID: <cc2ab2e8-452d-48b2-8e9b-1100a2c785da@redhat.com>
Date: Mon, 27 Nov 2023 11:23:05 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] target/arm/kvm: Unexport kvm_{get,put}_vcpu_events
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-20-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/23/23 15:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 20 --------------------
>   target/arm/kvm.c     | 20 ++++++++++++++++++--
>   2 files changed, 18 insertions(+), 22 deletions(-)
>

Reviewed-by: Gavin Shan <gshan@redhat.com>


