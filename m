Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ED9709B66
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:35:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q027t-0006vy-4L; Fri, 19 May 2023 11:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q027o-0006uY-Hj
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:34:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q027d-0007km-FB
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:34:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f41dceb9caso7106815e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684510463; x=1687102463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pb9IlaicBSZmt7qrRMrBNGyHNyEEKbiHOY+2Qsbwrp8=;
 b=OEm7ZVNFrEuKa0zKtRQstZVvGSPX5WsXc57vNzp2m2siW+Ukl2WW5esCMhd+94qKun
 IRmb9lUr4KhEAPfLJjdaeTGEGy3XoHDOvBmy719eQSsp3yQ5o2D6hRAi+httYS2RC4D7
 J/rmvmPeVgzy//wApP6CBDqwp1Jd91V8gmHWG8cAoRMlreUVBfMU0h0qfQzBKhF8VKgo
 Kb3gX/SoGMFAtmeD6GmMz5qTslyOnQ1hPl2kfwrdI63w8OrNtOLHhJdabPR691AjYjJD
 f93BqyOoWRkUAQozuOgPNEuA9g9amaQkLvusjrowMZXbZhC84O8DH454PjraaYTlLGCX
 5cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684510463; x=1687102463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pb9IlaicBSZmt7qrRMrBNGyHNyEEKbiHOY+2Qsbwrp8=;
 b=OuJYdNtT/WbCDk3/abP0PwN2ImCP25FFnFluZQMu4i7e51Zcz+IfDLTU87eHswP3Cs
 Q8ZuKnrbCqCgLzmVfu4O5JZR3BvqKnsvLYh3CCGrx7R5s+pUVF9YWdSUSDz09A2IJLZB
 LHxirt6gw/qKZJoGiKDAYp3ijml3GfoLhkpZ66dMenpg2ZHJ98KC8Fky0p/m181/svLy
 i+MC8EEYUm1SEt+4LcJqvFDlzziElxu/9X3lxy+JDEPA+UhSDftlVhoeCXfMMvtiNg7G
 kC2Km9oxgwjGNyEaAR5SYkuTz4ehV8Gcnll1z2RfQQT3ij3mWUmwfgUPNc5wX2/7ABRa
 rkNw==
X-Gm-Message-State: AC+VfDzYGcDTIheM+HQacotBXKg1M0efKvE22EQ2aQqoQLyEYu1yuBXm
 IcqUJ0fDkW70QaczL0oz7mX2ig==
X-Google-Smtp-Source: ACHHUZ7S6zs9OzweLMjvrmbwMW2f5GLkSI0QGJZiCAhjxUAHIGFy51/SczsTUK4bOM1a7pnTqHKHSA==
X-Received: by 2002:a05:600c:b97:b0:3f4:1848:4dff with SMTP id
 fl23-20020a05600c0b9700b003f418484dffmr1863436wmb.7.1684510463008; 
 Fri, 19 May 2023 08:34:23 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr.
 [176.184.41.228]) by smtp.gmail.com with ESMTPSA id
 z20-20020a7bc7d4000000b003f4ecf1fcbcsm2747095wmk.22.2023.05.19.08.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:34:22 -0700 (PDT)
Message-ID: <6dc139cc-ec19-196f-017a-cb0a415af3e5@linaro.org>
Date: Fri, 19 May 2023 17:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v6 6/7] hw/cxl/events: Add injection of DRAM events
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
Cc: linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230519143043.30191-1-Jonathan.Cameron@huawei.com>
 <20230519143043.30191-7-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519143043.30191-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Jonathan,

On 19/5/23 16:30, Jonathan Cameron wrote:
> Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
> provides information related to DRAM devices.
> 
> Example injection command in QMP:
> 
> { "execute": "cxl-inject-dram-event",
>      "arguments": {
>          "path": "/machine/peripheral/cxl-mem0",
>          "log": "informational",
>          "flags": 1,
>          "physaddr": 1000,
>          "descriptor": 3,
>          "type": 3,
>          "transaction-type": 192,
>          "channel": 3,
>          "rank": 17,
>          "nibble-mask": 37421234,
>          "bank-group": 7,
>          "bank": 11,
>          "row": 2,
>          "column": 77,
>          "correction-mask": [33, 44, 55,66]
>      }}
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
>   hw/mem/cxl_type3_stubs.c    |  13 ++++
>   include/hw/cxl/cxl_events.h |  23 +++++++
>   qapi/cxl.json               |  35 +++++++++++
>   4 files changed, 187 insertions(+)


> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 7e1e6257ce..5e82097e76 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -55,6 +55,41 @@
>               '*device': 'uint32', '*component-id': 'str'
>               }}
>   
> +##
> +# @cxl-inject-dram-event:
> +#
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
> +# This event type is reported via one of the event logs specified via
> +# the log parameter.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @log: Event Log to add the event to
> +# @flags: header flags
> +# @physaddr: Physical Address

Could this be a clearer description?

"Physical Address (relative to @path device)"

> +# @descriptor: Descriptor
> +# @type: Type
> +# @transaction-type: Transaction Type
> +# @channel: Channel
> +# @rank: Rank
> +# @nibble-mask: Identify one or more nibbles that the error affects

> +# @bank-group: Bank group
> +# @bank: Bank
> +# @row: Row
> +# @column: Column

Why do we need bank/raw/col if we have physaddr?

These are optional. Shouldn't we check they are valid
in qmp_cxl_inject_dram_event()? (No clue, just wondering
if there is some duplication here).

> +# @correction-mask: Bits within each nibble. Used in order of bits set
> +#                   in the nibble-mask.  Up to 4 nibbles may be covered.
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'physaddr': 'uint64', 'descriptor': 'uint8',
> +            'type': 'uint8', 'transaction-type': 'uint8',
> +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
> +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +           }}
> +
>   ##
>   # @cxl-inject-poison:
>   #


