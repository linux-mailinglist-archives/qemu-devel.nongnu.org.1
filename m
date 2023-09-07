Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E0797F43
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 01:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeOYY-0003nk-KF; Thu, 07 Sep 2023 19:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qeOYW-0003lE-Si
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 19:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qeOYT-0007Uk-LN
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 19:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694129816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n361xKlysaxEz02SXqn/w5GyHLFLFm1kA5g2GWzJXSc=;
 b=Ez/JILWxFFAUc4LxqUgEsKe1UJg4LrsUgGvpP3yKKvQ9bZclRwYL8t0En6/k7lONirLPrE
 EvTo59F52GG5bTSVZUYYZs35/LMRkPzoxi0OQZn2pVoIZLw3/U2TEq54yYo0BitSvDVAxR
 35fmFzd/+kgsyEZ2ElpV0CdSCi2Rhbw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-IKNiv-NiNl-d_NfCQ6wtwg-1; Thu, 07 Sep 2023 19:36:55 -0400
X-MC-Unique: IKNiv-NiNl-d_NfCQ6wtwg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-68bef1614e3so2009742b3a.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 16:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694129814; x=1694734614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n361xKlysaxEz02SXqn/w5GyHLFLFm1kA5g2GWzJXSc=;
 b=G+Uv0YlszMTIS12ubuJKwf5QZApErLO1OQKF0byfat32e2cKwJPXIKjq0AaVXRKsG9
 CP75ubxtvpXQuaj2mMur9bfnOb58NW+7nZoy3sWWCGfkdxlA2bnpSEACBdIVIy82kt3g
 u4/1AoT7oDhaLvzaf4xtSseTeHNsiOQ1dOrwZVYCPAq2hXNRp98jQtmi8dgvCVEcMQAC
 0r20nFw2DIGNLGYsFEeHFe4LXwVXy/oDYmV8La9OYAFP5MysUDjMGhmkO6GSQO53/FRE
 D/ShuQfaihRLGda1XCTGhNP0rcOw+YuAYHXNtGmt2kPKRystU4kemRNsONM39fSA5XQ/
 amiw==
X-Gm-Message-State: AOJu0YzmsG4Wm1rKYkGYn1jTvge+C6eqCLnVvUiRQEIE1jTMrmJ+XAr/
 dFF3WW9SZvdHp3JG/DwQzE0ZIXvvWOkb+Znr2Uo8tRX2JMBkde3igg5s2Asx8GHO05nqDAoOmFA
 2690fmehQEWjp99c=
X-Received: by 2002:a05:6a20:2587:b0:14b:f86f:fa54 with SMTP id
 k7-20020a056a20258700b0014bf86ffa54mr1346830pzd.15.1694129814297; 
 Thu, 07 Sep 2023 16:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGejhxfjgKy1onxnLXQ/GzQ/1zn9aUJOsHk/kW2MZnu7RMZMc4+wEnaK/grt3ftpK9fbIVS5Q==
X-Received: by 2002:a05:6a20:2587:b0:14b:f86f:fa54 with SMTP id
 k7-20020a056a20258700b0014bf86ffa54mr1346815pzd.15.1694129814013; 
 Thu, 07 Sep 2023 16:36:54 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 e12-20020aa78c4c000000b0068782960099sm233815pfd.22.2023.09.07.16.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 16:36:53 -0700 (PDT)
Message-ID: <e1215978-b196-8217-5710-afc9e4a4fcf6@redhat.com>
Date: Fri, 8 Sep 2023 09:36:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 15/32] target/s390x: Use generic helper to show CPU
 model names
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230907003553.1636896-1-gshan@redhat.com>
 <20230907003553.1636896-16-gshan@redhat.com>
 <2de76825-5a54-0d64-edea-27b118e3a03a@redhat.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <2de76825-5a54-0d64-edea-27b118e3a03a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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



On 9/7/23 18:31, Thomas Huth wrote:
> On 07/09/2023 02.35, Gavin Shan wrote:
>> For target/s390x, the CPU type name is always the combination of the
>> CPU modle name and suffix. The CPU model names have been correctly
> 
> s/modle/model/
> 

Thanks, will be fixed in next respin.

Thanks,
Gavin


