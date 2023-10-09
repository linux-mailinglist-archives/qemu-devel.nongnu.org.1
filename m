Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E52887BDD01
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:01:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpptH-0002qZ-5P; Mon, 09 Oct 2023 09:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qppru-0002PG-RO
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qpprt-00025b-88
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696856413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVeOrVDYzCTwq3+qFLAyha1MpRRMPTGSxY/f4KWrW5k=;
 b=dUtdJRI+E/R/kyyMQxs3f/UrN1thzAPB+bMcrd1KQOZz13yLkqfNCnfH4v8VE5Jvl6Iiwx
 QfM4jVIvl9DfSsulIvZ+uFTz9hXeNHe7i6EHqjgv5GLTXs+vFHegMLgGvYaMTCNfLQp3y4
 sxKhyhz/2FSnEvlI65daEXezGuVuIFY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-BIrXbDlGNUqAErWInMAWzQ-1; Mon, 09 Oct 2023 09:00:12 -0400
X-MC-Unique: BIrXbDlGNUqAErWInMAWzQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-668ed90e5f6so59860846d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 06:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696856411; x=1697461211;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sVeOrVDYzCTwq3+qFLAyha1MpRRMPTGSxY/f4KWrW5k=;
 b=pvfrTvlJiVZO4n2oh3+bAdzBNPXrlvWZO874P8yc1AZUDEJYqHmJB/aLQRWwztUJ6r
 yLgfCw/AQLyYxkIc2NBcWo9Gt/sAdTdM5AImHCTeGZ6s7vcVQUPESgkf3uZP/ZZGWg/b
 +2Q1yWcRNsx006jECoC+94ezJnLX85YM9CPhp1UQxitLbDSPJ5vOWppzk5t8SKSt6a1Y
 tJm0tgqPvcZoOOF8RBran05P0xJTneDqlXdAJwWHaX+4XSkwYb+sWiIAM5JhjeSFFu9B
 VVpqYTaareTk6afpt0MQlMgYdSSsYjsbmoCbYL2y80BhY+x4TXCpSC+BOtlScMbdw0RA
 cqgg==
X-Gm-Message-State: AOJu0YxtCW1+7VE02ZdY2qIafWVIPCjphGYOjrKh6gFbFB+i1DX5AWJm
 rnEhY9waLVL+zl9W5uqrgPEDfu+2/H6NQa/vUo/xOvBWC2ED5ebH+D94HIRST6KOny5CdMXl5v9
 7Zu2ZcEofSHlF4OA=
X-Received: by 2002:a05:6214:3b85:b0:656:49a3:21a7 with SMTP id
 nf5-20020a0562143b8500b0065649a321a7mr15384988qvb.16.1696856411475; 
 Mon, 09 Oct 2023 06:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCh8B1q9IjsEPU+qD+CJopwrwzIytl6cBTfmo1u3bM7vQAWrOt7r7X3060dGK2KAByJDyK/A==
X-Received: by 2002:a05:6214:3b85:b0:656:49a3:21a7 with SMTP id
 nf5-20020a0562143b8500b0065649a321a7mr15384938qvb.16.1696856410960; 
 Mon, 09 Oct 2023 06:00:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a0ccd09000000b0065d105f6931sm3824765qvm.59.2023.10.09.06.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 06:00:10 -0700 (PDT)
Message-ID: <88deccf9-4a80-23a8-f2da-4a141526b4a2@redhat.com>
Date: Mon, 9 Oct 2023 15:00:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] vfio: memory leak fix and code cleanup
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com,
 pasic@linux.ibm.com, jjherne@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, borntraeger@linux.ibm.com, aik@ozlabs.ru,
 eric.auger@redhat.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 qemu-s390x@nongnu.org
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231009022048.35475-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/9/23 04:20, Zhenzhong Duan wrote:
> Hi,
> 
> This trivial patchset fixes a incremental memory leak in rare case,
> and some cleanup on ap/ccw.
> 
> This patchset is based on vfio-next.

Applied on vfio-next.

Thanks,

C.


