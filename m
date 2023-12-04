Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADDF802B02
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:49:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0t1-0008ST-AN; Sun, 03 Dec 2023 23:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0sz-0008Rb-Cd
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0sx-0003o2-SB
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVYLKdRpULa58sp9ivP6sUn9SwoQjvwibKOTV3qhoIA=;
 b=DgftxluYKNXBHz4be+n4ld8HLcJIEGUDU57VSbKO9IJB4SPYpLqiX2dhZA1SzPI2/CAue2
 rMFjWAY4hKX1zIU2YKf1EB6/qekxaS2HLcc4Yq3DHrIWGqlp1kN8yEB9UzkVrptP4aQmwu
 JIus1A8lHdL+5JgdmacBdsbCZI+14HI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-ln3rOJKGMhGwd3JM7Jn_OA-1; Sun, 03 Dec 2023 23:48:45 -0500
X-MC-Unique: ln3rOJKGMhGwd3JM7Jn_OA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5c5e6009b98so1191795a12.1
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:48:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665325; x=1702270125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FVYLKdRpULa58sp9ivP6sUn9SwoQjvwibKOTV3qhoIA=;
 b=PJD3jJheokdQJTZzlJPEwBkKEfpfEpe7dz/svwv4M+TQmcr7Z1Lxc0xbuUfbdijzu5
 57d5WV0BQhzUx+eNJ9y7Hny/Rw2zXSOCBkLFFLTINUyddgzaQsduglpQTuyvbg365kmd
 wmB9gEt8oJgn8Vm2xmemqclJvFZrDTWLd7o/mxNPuFvHa41wA/GMwwEPNTlo0lHIGwFs
 VjWob9BpV8E2jPnj/0pqR3hZppa+PwEJzLdJLI0d9aWk5Bj+2kr3PT0EWm+GkFbtyikR
 7JprIQZSx4i45ZPIIYb/acVinb2aFyprTxFvUDlJCovtSsi6EJJianJdsudFvej30T/C
 HFdw==
X-Gm-Message-State: AOJu0YxBVUM7t8UGMneaxVZBr1gynzCjaL83EO1m9KDoTp4sETVHWgUj
 0TmCK1RBYV+lwspNowShCRO8JqoeLzfEOiisexJ1ljOWKomsvxSokwDB30csKibQm6wqVo1IxJQ
 /9YIhEQkv0ZNekec=
X-Received: by 2002:a17:903:2d0:b0:1d0:6ffd:8353 with SMTP id
 s16-20020a17090302d000b001d06ffd8353mr1113350plk.94.1701665325000; 
 Sun, 03 Dec 2023 20:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtq4FHh49+m0osXQ7gGggz8AzbHrR7CltiQJY2C8/3mpmaIcV6DfVePpf9cm04KDl7I7uEIQ==
X-Received: by 2002:a17:903:2d0:b0:1d0:6ffd:8353 with SMTP id
 s16-20020a17090302d000b001d06ffd8353mr1113343plk.94.1701665324714; 
 Sun, 03 Dec 2023 20:48:44 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:48:44 -0800 (PST)
Message-ID: <53f58429-9794-479d-8e60-bab3d64e09a6@redhat.com>
Date: Mon, 4 Dec 2023 14:48:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 07/25] memory: Have memory_region_init_rom()
 handler return a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-8-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/memory.h | 4 +++-
>   system/memory.c       | 6 ++++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
>

s/cpu_exec_realizefn()/memory_region_init_rom()

Reviewed-by: Gavin Shan <gshan@redhat.com>


