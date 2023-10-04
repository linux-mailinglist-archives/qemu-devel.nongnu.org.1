Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8937B80D1
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:28:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1tv-000855-I3; Wed, 04 Oct 2023 09:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo1tu-00084T-10
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo1tr-0007Hx-4r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696426010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJXwDMO0kvLWg+nqsg5Zr2ChoY1CgIe/vOujBdEiq64=;
 b=LHOg0aRyLnKQEzhpAMYdwjALaHJVe4dwJZHHrvItWQsp7w1XMAny3vV9dFp4y09VU6It2B
 fHkyTfBEZsXaUFIZwWGSm93hvs49GNGWfsz4g0plZgbek4av10WP84r58YVVjsgleBwIfM
 fbcyz34OZQ7raOE5RI+TZDCzvzQeg9U=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-qjythUx1MrOZ43pkGyh7dg-1; Wed, 04 Oct 2023 09:26:48 -0400
X-MC-Unique: qjythUx1MrOZ43pkGyh7dg-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-d8671837a86so2712542276.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696426008; x=1697030808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UJXwDMO0kvLWg+nqsg5Zr2ChoY1CgIe/vOujBdEiq64=;
 b=QMJB7EpYoA/HnidwA0ChMcjlo7kDui39t+Dec/wzd08zoHjgXVmwqT96BVHvYoc91c
 pr+Y2HB2dqbDN40w/QK5mvUCI17WQmWkhlAL8emt0ngQgVMEDxvYVPsFXqbSpR+GSgRn
 DQqK5kIM0wzey5GfKNWY4SyvIyjOFMmpPAt8h8OnonaXc2/wWuUkA3rrrflO0Z3fagQ7
 4faWDGdvkCvjks3fnvXZ9SkMK3oy47BZ/RSJAmeSwqqrqtZ9oB/9D/RwaVHJD8Hduqxq
 SrdCcv22kaNQHOHR/9aTUHwPtso3G77C/xMyizySaiAP8CJFRCxauzEfGxWTje2J+URK
 2Q9A==
X-Gm-Message-State: AOJu0YySkl/GiRguNXWtEIB9QvtKbXUOAoYZdLHTcRZKPmcwDAsJhIXm
 1qV9P/28VauOq7fvAoyr+oSEPta6Bn8bNebro93xJEv1oaTk9Olfsyo+QQy5VYspnLhxHywUmwa
 qegofcMKgaI6dbAs=
X-Received: by 2002:a25:d884:0:b0:d86:aafd:dcba with SMTP id
 p126-20020a25d884000000b00d86aafddcbamr2079109ybg.64.1696426007970; 
 Wed, 04 Oct 2023 06:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5c9QkxFakXUq8YSm4iSKXnFb4W3VWu5feqM+9tLyqUiu6VxchlcAbWzLOd6HsCKH76Zeb4A==
X-Received: by 2002:a25:d884:0:b0:d86:aafd:dcba with SMTP id
 p126-20020a25d884000000b00d86aafddcbamr2079094ybg.64.1696426007719; 
 Wed, 04 Oct 2023 06:26:47 -0700 (PDT)
Received: from [10.33.192.181] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a0caad3000000b0065b13180892sm1339151qvb.16.2023.10.04.06.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 06:26:47 -0700 (PDT)
Message-ID: <89be6f1b-7658-82a2-b877-7b89733430e3@redhat.com>
Date: Wed, 4 Oct 2023 15:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 00/13] misc: Rename 'softmmu' -> 'system'
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20231004132017.160874-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231004132017.160874-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/10/2023 15.20, Paolo Bonzini wrote:
> Queued, thanks.

Ok, but could you please wait with a pull request for a day or two to see 
whether we could agree on a better wording first:

 
https://lore.kernel.org/qemu-devel/85be2979-c0ca-3eb4-dae9-bbabf256c201@redhat.com/

?

  Thomas



