Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD86AE6118
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Jun 2025 11:46:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU0Df-0005Wm-Ua; Tue, 24 Jun 2025 05:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uU0DQ-0005Q0-GK
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uU0DO-0002l2-MH
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 05:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750758317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QlcCmVydxb1Rc0UTz+BwoTLb2cWodK3utBMhW5q94s4=;
 b=idq4Iv2HOXnYr0bo2FHtaCvYJb85YyjlwRbFa8fuHBMNk1SXk13L4lN56V8mstL0lY0pUH
 k/L3G6oAyi9OcFmIKra47sxAor7AMacAwKw10eb20w1JQpJvim9IS9JHTt1X6uOd5MY2Ya
 bx2BvBiNSUvq3opkv76YVcbLXckH/Pk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-QTjJZEAdORWTXTI8gcjl6g-1; Tue, 24 Jun 2025 05:45:15 -0400
X-MC-Unique: QTjJZEAdORWTXTI8gcjl6g-1
X-Mimecast-MFC-AGG-ID: QTjJZEAdORWTXTI8gcjl6g_1750758315
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso3220842f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 02:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750758314; x=1751363114;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlcCmVydxb1Rc0UTz+BwoTLb2cWodK3utBMhW5q94s4=;
 b=DPOx8kVdl+8et8hAUCOatRAexrU3qKnWDQpVTV+7V2NvYOuoNqJLUNDHRxVSPWckMK
 D5TS8qn6bg8V5IbqJY77SjEuFgKGJzo8mqdDlU2xtfyzkw9twdvcCI+mN3DHIT4hcVA6
 bfa6KmkAmccu8dff4HlQec7GHy/W6+EMkNwo2Ug4kLtoxC2A5LUFOxG6OTQb/e2Ucc1O
 ruB1xbkSDuowK7/obIrpR6kq7ddZykUMg9LkfcWpKHX5w50713qY8VZp0RgrdsOjviRw
 KoK1K/s/CCTqcQxweIcJf48xD+gJ12Q2Dq8FUOsplFh+wnVEb371F/z7rAnH+h/nB8pI
 vurA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLK11i+QGCnqgFB8XJKoxD4ShUsLOkHgoMKOTxgu0T4RAxJd2ZuX+WJLtugj3CyCrKxX4RqrLHUmuR@nongnu.org
X-Gm-Message-State: AOJu0YzyWf/uxNYAq90cAs1P9vhZanUe54bFtVYLw83nzMNN3fZwt4Jv
 +7Nm86pzTwsUnj/nbgFNP7zQUVqMsIUI25LD+VAAhmkF1P/d5wsK+ia4SKh3cV2v6Ta6OUqLzrc
 w7w2eGbP3k9z4DIJ2VrPZCTnLmajdZ6/gne4BDGEfw4m+dTfiGLKhKcW6
X-Gm-Gg: ASbGncsk4KJbV0Ev1uPMQuyfL/jIecR9XUrWG3L/QqPkENq0nFLgkNIhFVqFpRiP/x3
 lfhIQASiTRhBcXSqEtH0e4OQsScGQ3vXgFWIchaWymREb13Jb2I6XLL61cJNOXj/05yas+AvBPe
 IbNPI2Y5buipdBH5lFKAmjpHJ2uJafcErTDkptSqwuk1Nzwc40DgOQXQk6KOOsZOQU1TkoaFuQO
 Ux/XfgiGbmCGCXVNHeoTMFjSOQECgVnzGSWTBIGxxxP9PDONMqW7R3CjkXJEMYPyb34drsSjOAx
 cr2WMxat/PDKAYuJGtqOn2bgE6Xj/nlVEOBZfVgMDcvrU+RIG9npZrktBq97
X-Received: by 2002:a05:6000:2709:b0:3a4:dc32:6cbb with SMTP id
 ffacd0b85a97d-3a6d130710emr9041409f8f.31.1750758314663; 
 Tue, 24 Jun 2025 02:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiH0XOtkePWtcCYc5bIQXwjWKyQoPsoaMJqsEF5MuefXlLtJZW+smTy/2QGtuAY5uIC+EU+Q==
X-Received: by 2002:a05:6000:2709:b0:3a4:dc32:6cbb with SMTP id
 ffacd0b85a97d-3a6d130710emr9041390f8f.31.1750758314272; 
 Tue, 24 Jun 2025 02:45:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8051160sm1568157f8f.13.2025.06.24.02.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:45:13 -0700 (PDT)
Message-ID: <8a2d41ca-75f9-4b2c-b0bb-29129cedb1c1@redhat.com>
Date: Tue, 24 Jun 2025 11:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: add license tag to some files
To: John Levon <john.levon@nutanix.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250623093053.1495509-1-john.levon@nutanix.com>
 <78fc7bed-75cb-4d9a-b6e2-86b95319bcfa@redhat.com>
 <aFpqaC8HGEK5A7dV@redhat.com> <aFptjwzxKjvwYUgP@lent>
 <00590277-eb13-48b2-afeb-f99134fb3265@redhat.com> <aFpwrqX0idMrL34I@lent>
 <b7daa3c2-a9ad-419b-a84f-16054543ba76@redhat.com> <aFpyuj4481ycabfO@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aFpyuj4481ycabfO@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/24/25 11:41, John Levon wrote:
> On Tue, Jun 24, 2025 at 11:35:52AM +0200, Cédric Le Goater wrote:
> 
>>> These files came from hw/vfio/ and were then modified so would carry the same
>>> license. Please let me know what you'd like me to do.
>>
>> Ah. Please consider them as new. These are infrastructure files which are
>> all similar across the QEMU project.
> 
> OK thanks, happy to drop this patch then

It's a simple case and Daniel added his R-b. I will take it.

Thanks,

C.


