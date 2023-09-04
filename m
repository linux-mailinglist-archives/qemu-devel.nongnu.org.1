Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E4A791B72
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:25:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCNV-0006cj-MI; Mon, 04 Sep 2023 12:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdCNR-0006cH-Jr
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdCNO-0001OT-9Q
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693844671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lj0Bjpsfdw9VBp/7t7JcHkAAeoHZzPpAD9/UAbvcQYE=;
 b=MY0uth4mlVVl4MEixSHr49n1oc7KbYVh3ZbLDnmZeeMGwulhNNwqeIsEKznIDOx+RrNuxT
 0O/pffycx5MzfufOPPm9BzOIanAXteywQi6Ugs/MAeVvp+b3pmhrs9aWd3WBQPzly4IJ8B
 hz1Eap93h6hD0xVU3MUvTsL5LOtElr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-ZTybWnBBPMWCIo67wF1Mdw-1; Mon, 04 Sep 2023 12:24:30 -0400
X-MC-Unique: ZTybWnBBPMWCIo67wF1Mdw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31aef4011cfso909936f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844668; x=1694449468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lj0Bjpsfdw9VBp/7t7JcHkAAeoHZzPpAD9/UAbvcQYE=;
 b=ivoHL8eEXjPW44TKVfqPRBrZFUvtXJcuxUPOC/qgR1OXHNlatjHQy3v2VcMI+kJfSW
 /udxsVFLkYl5gyeu3uSpZPv3PCS3p0p5nIObcWgUO0DOkxL6/P+CftUHrcY3pNygt38N
 QkFJfitZT9fUjVECNnMAqIsQewWhUEtwifQ/s8V2K1ohmO6kG/JGYnw18gzReosYxlyW
 Z687PCrQojAOKtG4KDQ/n1ccFspnfDwtsatxk+6uT3At3BgRnmEUPsNRpo/kIKLJ/TjS
 7OdRT283516yDSa5BgFAbpz7mFLuVM3Ux7cCoPOkWVxwudbS0Up2HWtS63CV7MegJIyP
 BP8w==
X-Gm-Message-State: AOJu0YyjnIuuwpfvIXPSlsMWtFKj4p7bQLSOjKR/4kafvKRvbJCZutw8
 OzPehQF5YDLm3NghbonJfYf4uSzCy+81ZEFmkcUfe3TudvdG2seCggIzpWXWrKeFl6ykGcr79Fl
 Kzzz8lNmEBLgdqkwGQ3cxOuY=
X-Received: by 2002:a5d:4f8f:0:b0:314:36f0:2214 with SMTP id
 d15-20020a5d4f8f000000b0031436f02214mr7414293wru.6.1693844668429; 
 Mon, 04 Sep 2023 09:24:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAQZGnPnBJNihUQ9Q6YDGy2ZK2+mj31N8SiK/54n/m1t4JpTMW5qqWaNPMeZZrlnVkW0myzg==
X-Received: by 2002:a5d:4f8f:0:b0:314:36f0:2214 with SMTP id
 d15-20020a5d4f8f000000b0031436f02214mr7414283wru.6.1693844668086; 
 Mon, 04 Sep 2023 09:24:28 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 bh13-20020a05600c3d0d00b003fe15ac0934sm11022571wmb.1.2023.09.04.09.24.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 09:24:27 -0700 (PDT)
Message-ID: <eb3225a5-4c7e-d925-4163-27b595a91e7f@redhat.com>
Date: Mon, 4 Sep 2023 18:24:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 65/67] ppc/kconfig: make SAM460EX depend on PPC & PIXMAN
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-66-marcandre.lureau@redhat.com>
 <cb0e2856-afdc-294b-d111-28be168eeed2@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <cb0e2856-afdc-294b-d111-28be168eeed2@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 8/30/23 14:34, BALATON Zoltan wrote:
> 
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> SM501 is going to depend on PIXMAN next.
> 
> Why is this patch needed when SM501 is the one that depends on PIXMAN 
> and should pull in the dependency? Also what's the change in 
> default.mak?

The change in default.mak is needed because the default is moved from 
there to hw/ppc/Kconfig.  Without it,

     # configs/devices/ppc-softmmu/default.mak
     CONFIG_SAM460EX=y

     # hw/ppc/Kconfig
     config SAM460EX
         depends on PPC && PIXMAN

fails to compile without pixman, due to a contradiction (default.mak 
requires enabling SAM460EX, hw/ppc/Kconfig requires disabling it because 
CONFIG_PIXMAN=n).

> ati-vga also uses pixman and currently has no fall back. 
> The sm501 already has fallback when pixman fails so could work without 
> pixman too, see x-pixman property in sm501.c.

Yeah, this means there are changes needed in both this patch and ATI.

Paolo


