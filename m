Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4967C7DC586
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:48:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxgeq-0006XM-HT; Tue, 31 Oct 2023 00:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxgen-0006X9-IM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:47:13 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxgel-0004SD-C1
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:47:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cbf47fa563so40448145ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698727629; x=1699332429;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gdd20c42AmSckn1VV6IUgL4wr6tPqE4KgX2vLyJ5oTE=;
 b=jLGk7lr1T4Z+/Mzn9DXtWuuK7sfhULHYSZxUUutva+IneFDmZcyjEsxmj8NmHVuMTt
 Nulx+P0WMEATe/qu+kRKHw9tdTXx/ZSCVI9fAL9rUpsm0bw4B1dv/RfHRx/fx+UlqZWN
 glsYE2a/zeBigzA2uMMjwiWGGwQFMB46VbHFWq+YjKtui845nV2VAvlh6xTu+Ejlbn7z
 AtgLeD0BujiE+vYAo/UVDdml1Ojnq4JjnjDPcKHzJumByGpG94C3NYqGUCRUXv8TvbyE
 brhZGyVA7+iLUk8he+Q4sE1/JEDvt7Hd8TiGM6AtcoInu+gVXSCCV9DwWa/xLk/NlI6F
 Mcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698727629; x=1699332429;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gdd20c42AmSckn1VV6IUgL4wr6tPqE4KgX2vLyJ5oTE=;
 b=IRtZhELlWOfjkhjxrryC2LT/jTWeRFnAlVS36biuxZXrKcDxv926DZCYIUslTdN+N2
 GQfmPmhC5RUTFJmp2SArrGsQuRorjHhmZLHeinoGCRy2iI55ytnPWHDt6Zv/gfaYbahP
 Hal/EsBWJj9lQvQsXnESA5PeHTvFotObydql8DCewJy2ND6wz1N6Eau1CYSWOM6a5MXH
 WeF2UGySoH1VTqscCMoPHNZQujT0bxPy++ag1/9Jq3upYce66fV9icVRIn3cpkv+fsNd
 OWV52kFngSwBAyXD53X6jCtlnrj8Tm3a7LbDuv+eVZ/EohpDJ7q5R9XtX02s2pLoyAAN
 eN2g==
X-Gm-Message-State: AOJu0YxPIA5uOtraf2oXjg9AViuWTs4rwjCG6Y6IlP27aNEgXabnbmTB
 splyUiMMutsdyLagfpK5MehKNXkD8Z+k0aA2NkoxwQ==
X-Google-Smtp-Source: AGHT+IF88Bn6/nBbYs3++F8NS1UL4Ll3l3WZtGQLGzjy1paOHQnWCIe9dqKxuLjaYU7LD6RdWwBYJA==
X-Received: by 2002:a17:902:cec1:b0:1cc:345b:c7f5 with SMTP id
 d1-20020a170902cec100b001cc345bc7f5mr5202603plg.23.1698727629235; 
 Mon, 30 Oct 2023 21:47:09 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 iw15-20020a170903044f00b001c74718f2f3sm325900plb.119.2023.10.30.21.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 21:47:08 -0700 (PDT)
Message-ID: <bdd6584a-2d58-4224-a5b4-57ece7a7a859@daynix.com>
Date: Tue, 31 Oct 2023 13:47:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/21] virtio-net: Always set populate_hash
To: "Zhang, Chen" <chen.zhang@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-14-akihiko.odaki@daynix.com>
 <CYYPR11MB8432DFE20351884E5BBA27669BA1A@CYYPR11MB8432.namprd11.prod.outlook.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CYYPR11MB8432DFE20351884E5BBA27669BA1A@CYYPR11MB8432.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

On 2023/10/31 4:02, Zhang, Chen wrote:
> 
> 
>> -----Original Message-----
>> From: qemu-devel-bounces+chen.zhang=intel.com@nongnu.org <qemu-
>> devel-bounces+chen.zhang=intel.com@nongnu.org> On Behalf Of Akihiko
>> Odaki
>> Sent: Monday, October 30, 2023 1:13 PM
>> Cc: qemu-devel@nongnu.org; Yuri Benditovich
>> <yuri.benditovich@daynix.com>; Andrew Melnychenko
>> <andrew@daynix.com>; Michael S . Tsirkin <mst@redhat.com>; Jason Wang
>> <jasowang@redhat.com>; Akihiko Odaki <akihiko.odaki@daynix.com>
>> Subject: [PATCH v6 13/21] virtio-net: Always set populate_hash
>>
>> The member is not cleared during reset so may have a stale value.
>>
> 
> /docs/devel/ebpf_rss.rst:
> populate_hash - for now, not used. eBPF RSS doesn't support hash reporting.
> 
> We need update docs?
> And why not clear it in virtio_net_reset function?

Certainly the documentation needs to be updated.
Either of clearing it in virtio_net_reset() or 
virtio_net_set_mrg_rx_bufs() is fine.

Regards,
Akihiko Odaki

