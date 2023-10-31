Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0F97DC593
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:58:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxgoZ-00086L-8e; Tue, 31 Oct 2023 00:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxgoW-000867-7N
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:57:16 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxgoU-0006Bs-4m
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:57:15 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-586f68b78ddso1289082eaf.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698728232; x=1699333032;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x6Lc+5sz46UlDIYc0iwPAVa5urjJ86FK47hpcl478Qc=;
 b=tcW080+/wCAOhPJ7VMkZ8Wg9rW5owwq9oV4+Uqy/DqlrHUSt9sNXdXuxOw80pJU+UP
 OqiwUcpciAt4AmIy/3zYFwmt58fyGwltVRbeEfLA5UCbfaOcNuQO3VEF23y3xlfTS8wF
 Y3pvedz+eLyX/4EFQJtETh3iLZs/IhiMm7nZpjJKRpVYoMstjwixll6xW0ObyJ841saA
 BqHyL6WP441K/F7Y3DlLNXA2Dqy4z/HXjIMouXZc0dEenDRweS4JjeyKXSJtXRjn758j
 qtnN24Slx50lFI36o0X4jdZ0k54Rqc/v2UzpNhBdOLCBA7i0+1yXdmZVv10CirLE7WZq
 OJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698728232; x=1699333032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6Lc+5sz46UlDIYc0iwPAVa5urjJ86FK47hpcl478Qc=;
 b=mtnJbF81o33vQBdktS6zNS8K1Mupi8lHQ49XbSNotq5Mc3KEYjP8OCXDsmy1jcUJ9F
 iZH+O97RVeJifGmlaVaEOnGs8ZTUEVD/AYmaNlZh733/VHQ+IBcBJqseVk0pHXr/0X+j
 Ao4jkUZk2jsVDwWdn7ACqP8vz/wJl1PS0QF91L447h2rDDwIcGhsMyAj9W4SK36QRum5
 fZOchb0zZUEgI1UEazXncrcMX9E7awSyrDutoUzi+Iy1BCsb17iAo52Zutb7cqfMp9qX
 kqoUt3mWVWnGj6V2QhT96iE2J4zyyzJDT81MIpfy1KNuvqvvlamaW2Di9Gfus4952odH
 8UKA==
X-Gm-Message-State: AOJu0Ywl73QybvYzAENwkR/EeOW9SwydrLpq6saE0q6H7YciiRWrFQDB
 M9mKmYOnwe7t8VuROgxtfCtXZw==
X-Google-Smtp-Source: AGHT+IHyFnveaajbA4oPJv+QxfZRdjvrJBj4E/fWVX4yXmOMp0nDW0XMYbl9IH1nE1ZXSrYekKFi7g==
X-Received: by 2002:a05:6358:720a:b0:168:dc41:b7b0 with SMTP id
 h10-20020a056358720a00b00168dc41b7b0mr15197856rwa.0.1698728231649; 
 Mon, 30 Oct 2023 21:57:11 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a63bd12000000b005b9373f574csm314496pgf.74.2023.10.30.21.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 21:57:11 -0700 (PDT)
Message-ID: <d2ac8914-58bc-4860-8c3c-65f2aeef8ac6@daynix.com>
Date: Tue, 31 Oct 2023 13:57:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/21] tap: Remove tap_receive()
Content-Language: en-US
To: "Zhang, Chen" <chen.zhang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-6-akihiko.odaki@daynix.com>
 <CYYPR11MB8432F991FBE071C91C4CCB179BA1A@CYYPR11MB8432.namprd11.prod.outlook.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CYYPR11MB8432F991FBE071C91C4CCB179BA1A@CYYPR11MB8432.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/31 3:52, Zhang, Chen wrote:
> 
> 
>> -----Original Message-----
>> From: qemu-devel-bounces+chen.zhang=intel.com@nongnu.org <qemu-
>> devel-bounces+chen.zhang=intel.com@nongnu.org> On Behalf Of Akihiko
>> Odaki
>> Sent: Monday, October 30, 2023 1:12 PM
>> Cc: qemu-devel@nongnu.org; Yuri Benditovich
>> <yuri.benditovich@daynix.com>; Andrew Melnychenko
>> <andrew@daynix.com>; Michael S . Tsirkin <mst@redhat.com>; Jason Wang
>> <jasowang@redhat.com>; Akihiko Odaki <akihiko.odaki@daynix.com>
>> Subject: [PATCH v6 05/21] tap: Remove tap_receive()
>>
>> The receive member of NetClientInfo is only for legacy clients and the
>> receive_iov member is always used when it is set.
> 
> Under normal circumstances we still need to maintain compatibility.
> It seems that there is no need to remove the tap_receive here.
> You just need to optimize the tap_receive to call the tap_receive_iov.
> In the history, we can see a large number of devices still keep this interface,
> For example, e1000_receive can directly call the e1000_receive_iov.

That sounds a good idea. I'll do so in the next version.

Regards,
Akihiko Odaki

