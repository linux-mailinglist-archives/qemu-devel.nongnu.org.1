Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E057C8004
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:23:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD8p-00018w-Fp; Fri, 13 Oct 2023 04:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qrD8f-0000v6-Hd
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qrD8e-0008Sk-4d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697184195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uwO7oX2sQz7hr6NHzy0ALgo0C95V8X0eMoCPkoy5aaQ=;
 b=UjWUgAarvAq0hVYfnBGQgIu8LVjDChU5o6YmfcwABa21rkXD5wtdzMfVKLo9JbR25i9qCV
 4bOzJvtoRIJPmMk0tvo6Qk02ykP/1ZFD8fKajH6zT8ZKYPJh30Qzqa0jwjzsoJCJa/qpda
 Ug9Mb7oFZo1KJ/UNlqsxlAr/1iuPcLk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-2sFlUCoPPL-bMUNrPqPRYQ-1; Fri, 13 Oct 2023 04:03:13 -0400
X-MC-Unique: 2sFlUCoPPL-bMUNrPqPRYQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32323283257so1151773f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184192; x=1697788992;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uwO7oX2sQz7hr6NHzy0ALgo0C95V8X0eMoCPkoy5aaQ=;
 b=WZ1MdWesFyrtF60oaYXmdaxySCjIDvhshv2MIbGvDKZati2qMnax2ntPNxOVAPi2/h
 gGOporNpldG9j/fcINYJWBcyGYKa3bPVjRAANTNe+p7rNdkTtIwJ7plL6rihtGLd4YJB
 73v+GlpSHGN9smxXdWfmrAVqu779IGA0efYLix4+xwED5itNdSPGto/TVPH+usxR19Mm
 tv5g/PEQIcU9sM/7uhjeEpru7x+DVCgVz9AB3A0CeW3nS2j172TAqQjO8jjIM3DV6yOQ
 HuftFQRfGkn633oZcqnu6bHiNAzxmv5tgrlvMLH6eI78rI06kUO5Bvgzrjsuu4T/y+yU
 tbhg==
X-Gm-Message-State: AOJu0YwGr8SJHPckaid1WbWfDZpvIvvKfj4hMqEoPj4DhzyRdP6N8GR9
 suoZx3psLq0AbBPefQlTqPpo505hwTzJGtPimop/PVnf4jUZh65q5cuvX8qJhMtVqirwc+jEKGh
 V2Hlku4hAN5oFQrg=
X-Received: by 2002:a05:6000:1001:b0:32d:81fe:7104 with SMTP id
 a1-20020a056000100100b0032d81fe7104mr6568453wrx.63.1697184192626; 
 Fri, 13 Oct 2023 01:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/iq7SqbbZzunKyfE4cSQCs26lQVJEJeuQhode2ggyqPD2DuD3kWfo+J1+sxfVrRlsSl91Pg==
X-Received: by 2002:a05:6000:1001:b0:32d:81fe:7104 with SMTP id
 a1-20020a056000100100b0032d81fe7104mr6568423wrx.63.1697184192239; 
 Fri, 13 Oct 2023 01:03:12 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6028.dip0.t-ipconnect.de. [91.12.96.40])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a056000054500b00326dd5486dcsm20254254wrf.107.2023.10.13.01.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 01:03:11 -0700 (PDT)
Message-ID: <664d6767-32c4-bd4d-ef5a-d102bd2facbe@redhat.com>
Date: Fri, 13 Oct 2023 10:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 71/78] hw/s390x: add fallthrough pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "open list:S390-ccw boot" <qemu-s390x@nongnu.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <027ebef63f822f425c496a49112b38a62305b3e5.1697183699.git.manos.pitsidianakis@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <027ebef63f822f425c496a49112b38a62305b3e5.1697183699.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 13.10.23 09:57, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>


See Rb's on the other two patches I was CCed in v1.

-- 
Cheers,

David / dhildenb


