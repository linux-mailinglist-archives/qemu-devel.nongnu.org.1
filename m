Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B70AF836BC5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:51:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxVg-0003RL-Ah; Mon, 22 Jan 2024 11:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rRxVU-0003Ng-W6
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:50:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rRxVT-000415-Bo
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705942241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h85iaIRTG/IVHbfLP7EuPW6M6By6uebq9dK+46+hsf4=;
 b=VW+T8qAqO+h01PAadtSaTQKwFd9X1CYykC75uK5kWCkx+Hnxh3lU34oS13Sp+iAknqSn8T
 +PwHmOH5bAK2sDjW3cHRzAlT+6qZrSiG71rJgMZP7uXwGB1je6rLyBgo6Vtb1VoWoT8B36
 Pm4ul51kSRGKYWAt5gCAm2F9Vc2Kc0E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-2W_elsupOMiG0wyA0dsEZQ-1; Mon, 22 Jan 2024 11:50:40 -0500
X-MC-Unique: 2W_elsupOMiG0wyA0dsEZQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40eb06001c2so7041425e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 08:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705942239; x=1706547039;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:from:content-language:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h85iaIRTG/IVHbfLP7EuPW6M6By6uebq9dK+46+hsf4=;
 b=ssBuqwvVPNU48QudYjkMfJ1oLwsHKb4IkJc1CvOBVPfomWpjZcfIkIzStD5ahJMHWH
 0i0iE6QFvcHZzzpQ1UZfzvjEDGuya8CUIFnUnx9fH+rR5bLxr09xRBKDnRLN/GBIxd1J
 gsNG6Z+XLrprDaIStK6LmdEN7y/OG6grZ1+8V+qO8Ce9tCliV25XYeHeveoD0cagrZkT
 8Ht9jlFqTn+NtJgL50wVih+bdeIJ7WDfeNF27YtDPQXOmpPeNYU+bQf8yzXgIpZf4ib2
 zphHzslkFsZbjKDOhCb9+rpSIIkQlSz5kItIfpWkSuI03x6O2ZmsGQ4/3U7QTp0WeQ9M
 IH5A==
X-Gm-Message-State: AOJu0YxLcOkXEt+vv2yCXW5ZLZcx3Q9yZbGCYb0vB9ZKlohMMCAKIdNi
 y7ghBDwTOmOUoVjrkKDXmn5BzNcLkrn97/GfmY/vRrv7eg9Sxgls4nS1kqut3p55w9dvW9Ak7b7
 GSIGc5mbuzfiDsFdsmeOHj/UybKEfUrxB9rjjXviUqWpEX/dffYq2J+VtWdgGtY4L4t9/uH2duj
 W7obsm1tY/Hq9aj2HPR5yR+ilTS5fBToZL
X-Received: by 2002:a05:600c:154a:b0:40e:3505:32eb with SMTP id
 f10-20020a05600c154a00b0040e350532ebmr2365138wmg.133.1705942238919; 
 Mon, 22 Jan 2024 08:50:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKdaJieY3nHN4RXJSsSRlJVExfZlGm0BwD6WkCmF7ByxIYHs+0SE8I+fjPrQjVy2pI3BNk6A==
X-Received: by 2002:a05:600c:154a:b0:40e:3505:32eb with SMTP id
 f10-20020a05600c154a00b0040e350532ebmr2365127wmg.133.1705942238520; 
 Mon, 22 Jan 2024 08:50:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c737:f400:b194:1841:c4a5:75f5?
 (p200300cbc737f400b1941841c4a575f5.dip0.t-ipconnect.de.
 [2003:cb:c737:f400:b194:1841:c4a5:75f5])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a05600c45c800b0040e527602c8sm43861690wmo.9.2024.01.22.08.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 08:50:38 -0800 (PST)
Message-ID: <8d8bbeb5-efde-45f7-97a9-c31bfac51993@redhat.com>
Date: Mon, 22 Jan 2024 17:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] memory-device: reintroduce memory region size check
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mario Casquero <mcasquer@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20240117135554.787344-1-david@redhat.com>
 <a8fd0d6f-70d6-4f46-a8ad-10aaf767dbe3@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a8fd0d6f-70d6-4f46-a8ad-10aaf767dbe3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22.01.24 17:49, David Hildenbrand wrote:
> On 17.01.24 14:55, David Hildenbrand wrote:
>> Reintroduce a modified region size check, after we would now allow some
>> configurations that don't make any sense (e.g., partial hugetlb pages,
>> 1G+1byte DIMMs).
>>
>> We have to take care of hv-balloon first, which was the case why we
>> remove that check in the first place.
>>
>> Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>> Cc: Mario Casquero <mcasquer@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
> 
> Thanks all for resting+review. Queued to

Haha, "testing" :)

-- 
Cheers,

David / dhildenb


