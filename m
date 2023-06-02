Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E16720249
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q544j-00023C-QN; Fri, 02 Jun 2023 08:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q544g-000222-RT
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q544e-0001b2-RX
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685709608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wH2RFKFMZ57I91PVNLynXl0guAu871CUSku6s3u1dc=;
 b=J06oY+BN8VjyZdg3mVn9KHnuwsulkT/X+6KcioOzKUBM+OaWW4EbPywIqR0XPYYyL6gotv
 KjpFVmT13b0ZsgQRN9PDswsr7yRKjDDT7+LnVrNHdEd1+xcwXqRc/mZ8kg4ZPDcVkT8Qhq
 fjixBNet1mJEbZKvlQ7J+qx/4IK06sg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-pyNEO_l1OiiSUVU9C4EPOA-1; Fri, 02 Jun 2023 08:40:04 -0400
X-MC-Unique: pyNEO_l1OiiSUVU9C4EPOA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f6cc1997fdso11128725e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685709603; x=1688301603;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3wH2RFKFMZ57I91PVNLynXl0guAu871CUSku6s3u1dc=;
 b=QaAb/vX6zFYPRmybzilcrXHM0pprOgvid9auS7rMmVvCbhGgCvwdL8sO+tB7xFklqe
 OySIhEK4hr11yVjc5T4vZWCE2QF8j3K25i27p/lXwsLX57zTPRF2du1Uba6nlSOY+E6z
 dnE7TcU7Uc0EqruwqmGzdi4VtwV50VeCdByHjwyOcPoAZ/KpbDQEBSebqgXgjOWwtgc/
 YikcQPY4VClzTZU8uppDchJH0KM1DlZIbmIeWdZESFm4ubgIpvZiLsTo8pen11xtMo8S
 Dj8l7LREXl7NWkiaEg5ZXakS6p9BhK5adLlknvhpIlAodiApLyUglMjwADi1pEoca+OY
 vFiw==
X-Gm-Message-State: AC+VfDzcO8dG0NQ0pBjPVMUc7niDzt7Va+2pUDooKaMKP5univa/bvnc
 Gelcdj5mb4JXzno6Skp7CzIL3ECmRGLXkEWLzJ3humIv/U3hsOqWIs0669uAG85HcJAMqiEWLnv
 QNGbqaUCpmX8Itsg=
X-Received: by 2002:a7b:c7d8:0:b0:3f6:148f:5867 with SMTP id
 z24-20020a7bc7d8000000b003f6148f5867mr1744734wmk.4.1685709603241; 
 Fri, 02 Jun 2023 05:40:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ726lS1Z0uxFP9VYEyjBQSdncsfq2NuPtsx2mAjFDcqo3nU0I/AkvpIa7ykMXzUydlFRM6Ugw==
X-Received: by 2002:a7b:c7d8:0:b0:3f6:148f:5867 with SMTP id
 z24-20020a7bc7d8000000b003f6148f5867mr1744715wmk.4.1685709602936; 
 Fri, 02 Jun 2023 05:40:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 a14-20020adfface000000b0030add836194sm1582495wrs.65.2023.06.02.05.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 05:40:02 -0700 (PDT)
Message-ID: <64f3b405-8fc4-13ec-5da3-f139ddd6a248@redhat.com>
Date: Fri, 2 Jun 2023 14:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] target/s390x: Fix MXDB and MXDBR
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Tulio Magno Quites Machado Filho <tuliom@redhat.com>, qemu-stable@nongnu.org
References: <20230601223027.795501-1-iii@linux.ibm.com>
 <20230601223027.795501-2-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230601223027.795501-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 02.06.23 00:30, Ilya Leoshkevich wrote:
> These instructions multiply 64 bits by 64 bits, not 128 bits by 64 bits.
> 
> Reported-by: Tulio Magno Quites Machado Filho <tuliom@redhat.com>
> Fixes: 2b91240f95fd ("target/s390x: Use Int128 for passing float128")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


