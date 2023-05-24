Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48470EF3A
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:18:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ikU-0006ik-L1; Wed, 24 May 2023 03:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1ikS-0006iG-2N
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1ikQ-0005ii-NI
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684912646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfhVnW1+xMguL58me2qfT/dx9arnckGTFXzDzkOrYAM=;
 b=Tc8pG2QLATDtyRdwcoJx7ckDPjHEYsNPeUGw2bx6cOsUQePpakcgrkAKYu48K8jnEItpU3
 iBME+kmW3XbeoJbqAl/GpjO9m8MsrZSeq9fWCQhKIoZ5uYjYQA/RgII8KnisDXxAC90kpk
 uPeGZDO5k5rwsiqcxtnuqH6MjSrY2vc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-FHbGVWxMNdez88OJau-ObQ-1; Wed, 24 May 2023 03:17:24 -0400
X-MC-Unique: FHbGVWxMNdez88OJau-ObQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a34e35f57so49620266b.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684912643; x=1687504643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qfhVnW1+xMguL58me2qfT/dx9arnckGTFXzDzkOrYAM=;
 b=OcBxLl6Kz2eRR9Z4ZBTCZJC2JE4/NfDkOIB71JdXGObgv6wd3Q4VM7+vAOPkJg0BGs
 c+wZlxTou+mCCdZb8tbmUPcO4NbMJQJ+4hnWsegGkPAD9GWi+sBhkhnZZX1PpanqKv0A
 rnA92OooYGoFzzeaJOXy2N8gLO4yfLu3fkUtnJNOg2/cGmdr9PQd8S4w5zRooU3cNiTA
 Rrro49e765yWsu/WlLEsHfA0BoQh6B3vgUDKBazkD97Ht9IV45ahBScL3pookWFBttNm
 Za44KRfW8OUWHvsH7H+IgueEKo23NY31LRk2voefYq/IfiNoByc7VMqD7rMAYiZU0Hko
 AjDw==
X-Gm-Message-State: AC+VfDyC/uvd7yBtD2GRpp81qzDWXdTCy9kEmJsBcU56ZAKodFM0qWeR
 t5OqiQoYOuv1cb0vcWRM1uWElAz3h2Cy5nQn7tfV/nACeNvyo72NO7Fx1km0Zcp4iBA2eUqggCX
 aqq8jo4YL0G0msjc=
X-Received: by 2002:a17:907:3e97:b0:966:350f:f43b with SMTP id
 hs23-20020a1709073e9700b00966350ff43bmr18752988ejc.9.1684912643256; 
 Wed, 24 May 2023 00:17:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ421kCUR/d4/Ogje37D7jFfKNz3nTL8rz2dl81Qkupactk9gpMoTB2YfUSjkqjGpAX9ZK0vKQ==
X-Received: by 2002:a17:907:3e97:b0:966:350f:f43b with SMTP id
 hs23-20020a1709073e9700b00966350ff43bmr18752963ejc.9.1684912643000; 
 Wed, 24 May 2023 00:17:23 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 u10-20020a17090657ca00b00960005e09a3sm5392438ejr.61.2023.05.24.00.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:17:22 -0700 (PDT)
Message-ID: <dfe264c9-a1d9-609a-6c80-502e3213aed1@redhat.com>
Date: Wed, 24 May 2023 09:17:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/11] hw/virtio/vhost-vsock: Include missing
 'virtio/virtio-bus.h' header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-8-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523163600.83391-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 23/05/2023 18.35, Philippe Mathieu-Daudé wrote:
> Instead of having "virtio/virtio-bus.h" implicitly included,
> explicit it, to avoid when rearranging headers:

s/explicit it/explicitly include it/ ?

With that change:
Reviewed-by: Thomas Huth <thuth@redhat.com>


