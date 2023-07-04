Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C928747232
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:05:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfi1-0000Ll-Pm; Tue, 04 Jul 2023 09:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfi0-0000LY-Fh
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfhz-0002vG-0z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688475882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HiMORpNhjWVPCDQ6FrSV7sOq+24/gJC8HAOuiDX2wFs=;
 b=JX2IvpoIIymA5B6nwBSh9hIMpOsb9lXIsKCNj6lJ7scW6cflWNFFs7jEw50e6FGnrznRrP
 Ia6xQJejwjTV5d7kS+hHjpTVZ/u2u5ftnF1ebujEL0Uu7pYCPEGcRlhwV6THhf1VVG7FuI
 4+fkgGDAXF42D8YICSoNx7aCuEj8xgY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-XtASBGw6OHiGZm44QKJeAg-1; Tue, 04 Jul 2023 09:04:41 -0400
X-MC-Unique: XtASBGw6OHiGZm44QKJeAg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-765986c0521so472337385a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688475881; x=1691067881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HiMORpNhjWVPCDQ6FrSV7sOq+24/gJC8HAOuiDX2wFs=;
 b=DCZXzhSYN4Qe0TDATEUeL4i4YnrR5S0CCMQt38Y2gGzr2LMeQxZZYUcqa+rKXcx1J6
 NZxcVu61Gt9taZlNXHlXl+XCU5OeqwWnLOdMVxzNbTwFKCxG2xXJJ0DzGbA0Na8Ih6NH
 YXEDAywINwsr78PEkGiXxK4Cu+8pbvaQeeDbexoPmG2QrIPfgUfF0gLRdoCm+oaefVUn
 Hx1Hnc8gJl+hveWXHKyTf8q7ZogxvwfrNXZ/8ku+e1pwJJOYLxIGLFctp04XrT/j3dGl
 ZIToeljBxaZnjls71OHmyjdJAaFx/5gGw1a2bxb6fbmGtHum3hYINXux+ky3e+MkGPAH
 TukQ==
X-Gm-Message-State: ABy/qLaKaC5KSDFr19L1wT90wDjcwCdkMjfXTzP/4Jckl1tBOe1Pe8fe
 +RDVKKf7Ny6iz+BOjj1fKKf3bjAJBmpUdj8Jiw5TZw9vFi57Sw4Ot0FJR508Ij0Wij7/4epiG6t
 XjIAdslhjqPYpMgE=
X-Received: by 2002:a05:620a:2482:b0:766:a495:63f1 with SMTP id
 i2-20020a05620a248200b00766a49563f1mr13504742qkn.59.1688475880907; 
 Tue, 04 Jul 2023 06:04:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHFHBoOkQUk9Emv4Y19561lhidPw9OK4Iv5arBEnsDeGT+T+gXIEW0yOC/CaRpq1TIu4NMGbQ==
X-Received: by 2002:a05:620a:2482:b0:766:a495:63f1 with SMTP id
 i2-20020a05620a248200b00766a49563f1mr13504673qkn.59.1688475880163; 
 Tue, 04 Jul 2023 06:04:40 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-126.web.vodafone.de.
 [109.43.179.126]) by smtp.gmail.com with ESMTPSA id
 c20-20020a05620a135400b00767171e4eeasm7537417qkl.2.2023.07.04.06.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 06:04:39 -0700 (PDT)
Message-ID: <579d40ea-50e4-4d84-699b-25268749b138@redhat.com>
Date: Tue, 4 Jul 2023 15:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 11/20] qapi/s390x/cpu topology:
 CPU_POLARIZATION_CHANGE qapi event
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-12-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-12-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/06/2023 11.17, Pierre Morel wrote:
> When the guest asks to change the polarization this change
> is forwarded to the upper layer using QAPI.
> The upper layer is supposed to take according decisions concerning
> CPU provisioning.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   qapi/machine-target.json | 33 +++++++++++++++++++++++++++++++++
>   hw/s390x/cpu-topology.c  |  2 ++
>   2 files changed, 35 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


