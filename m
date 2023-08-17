Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03177F067
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 08:13:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWWG9-0003EO-MH; Thu, 17 Aug 2023 02:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWWFx-0003CP-JV
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qWWFv-0006tX-21
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 02:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692252793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2C0wubYS+7S6gtlXMOa/UiSn72SxNEnLXWjK9pV1oU=;
 b=UYc7SXdMUqe86DhCecI9DhLPLqR0c2+HVSKZ2QcPjNbpYAP043XgYyZj3ynAwQfmnwg4Xo
 dnSPZb3MyLF1pagRmZt3GE/dmGxXGSLC+ZgXw/NRaJPpYD/CnpmmiV79Fr0XtI3lPQR3Xg
 SgEyvYFexmxTBhCEWkXPktdjn8oahIg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-nWH3HOTtOTq50SERKgNiuA-1; Thu, 17 Aug 2023 02:13:09 -0400
X-MC-Unique: nWH3HOTtOTq50SERKgNiuA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9ba719605so78470301fa.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 23:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692252788; x=1692857588;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V2C0wubYS+7S6gtlXMOa/UiSn72SxNEnLXWjK9pV1oU=;
 b=fPssIwf5t+wHZQw+7No2h/6Gxzuex81qpHWlLT0TbI/G/FcQ75LqXHs72DJ43m5amU
 Lzm6qhLxmBT0bRJU5odMzWDrsrqX2Lyfr0tFYlK51/FN+U7m1Px3bz+EGCKHbXyMvRKa
 UVrW9pzhYIW+sTUxHORZEfvVkj6+laX78rmRj2hyUnWFSimzr1beZDuLYcDodt0QobFE
 hts0DDttCrPmOlhjS6hmuSEdnrbxJxvzhTNDoGc2/Gl6S9t7Pj39MXV2TbRKZywdsrip
 NmfPtyNY5744qQ+C8MD+XFhgg6fTsmX3am4V7ckiLjnvUYVDEIYZG5C9Io74vCQ01BBP
 vxKQ==
X-Gm-Message-State: AOJu0YxmQCNOB/7vGyC+nzEsH62AuRiDXb6gf42SsOYJE3MS0ShKMOd9
 gos8NmN6hrbvMaxRlGY9ABWNGyRM4TA9MV+deKYrKXpb65gGbnTjiN4EKx7DTU+ezhWU/LpJjxe
 saQUewlMCg10QLao=
X-Received: by 2002:a2e:3c1a:0:b0:2b6:e96c:5414 with SMTP id
 j26-20020a2e3c1a000000b002b6e96c5414mr3130690lja.52.1692252788237; 
 Wed, 16 Aug 2023 23:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCS7xWeaVvkVEdhppn8/iqD1DDGbK4oEg0vvQZ8glIT3Zv5z/1WyrmxgSVn2gLyPsME5FUpg==
X-Received: by 2002:a2e:3c1a:0:b0:2b6:e96c:5414 with SMTP id
 j26-20020a2e3c1a000000b002b6e96c5414mr3130674lja.52.1692252787923; 
 Wed, 16 Aug 2023 23:13:07 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-113-156.web.vodafone.de.
 [109.42.113.156]) by smtp.gmail.com with ESMTPSA id
 y19-20020a1c4b13000000b003fe2a40d287sm1694907wma.1.2023.08.16.23.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 23:13:07 -0700 (PDT)
Message-ID: <d363975a-e2e0-03b0-b75b-66881269160c@redhat.com>
Date: Thu, 17 Aug 2023 08:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: QEMU Summit Minutes 2023
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
Content-Language: en-US
Cc: Paolo Bonzini <pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.165, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 13/07/2023 15.21, Peter Maydell wrote:
> QEMU Summit Minutes 2023
> ========================
...
> Topic 3: Should we split responsibility for managing CoC reports?
> =================================================================
> 
> The QEMU project happily does not have to deal with many Code of
> Conduct (CoC) reports, but we could do a better job with managing the
> ones we do get.  At the moment CoC reports go to the QEMU Leadership
> Committee; Paolo proposed that it would be better to decouple CoC
> handling to a separate team: although the CoC itself seems good,
> asking the Leadership Committee to deal with the reports has not been
> working so well.  The model for this is that Linux also initially had
> its tech advisory board be the contact for CoC reports before
> switching to a dedicated team for them.
> 
> There was general consensus that we should try the separate-team
> approach. We plan to ask on the mailing list for volunteers who would
> be interested in helping out with this.

So who is going to drive this now? I haven't seen any mail on the mailing 
list with that question yet...

  Thomas



