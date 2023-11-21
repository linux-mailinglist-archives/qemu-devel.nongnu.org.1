Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 507B27F31DA
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:04:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SI9-0001cf-9e; Tue, 21 Nov 2023 10:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SI6-0001Yg-J8
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:03:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SI4-0005NZ-SO
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700579031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzV2gdyZdVU2Y4g4r338DfTveOi2Ma2n/9vLEvzwf8o=;
 b=QO6G4Zgep6ODtMpeUyHXuGNFy6UzFoN41JiR7YcLWMoPQEXPOFDxpb2mDyRi3cGORRLqs4
 un3mXc9zLdC1z3L6La4uvqyWVPlEqhY8kJPlfXo0laX73qopEZ9YdXi+ufHAn+8mtKbbo9
 8HJYT9sXlGVyb3BdbGO8FWzlalKSUxQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-_6MPkBZPOhOA0ugRsAGmVg-1; Tue, 21 Nov 2023 10:03:50 -0500
X-MC-Unique: _6MPkBZPOhOA0ugRsAGmVg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77891ef5fc9so75850685a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700579030; x=1701183830;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yzV2gdyZdVU2Y4g4r338DfTveOi2Ma2n/9vLEvzwf8o=;
 b=Kd0z2fEgAU30chxSrKPUKVitTv6nOXc9mTfXDW0/UT7tVL1JvlnAboZoWk64Ye3SSz
 FxNqwK66wYZ9HR3Kff6zdMQ35bTPyrECIBMYscowZNAVy/mjyvgSD+rZ6DTdKKrRjCgs
 2P4SZFSI+rxvJ7peDlmJCmN9zbs28VF2wEqq8w085KPPzDGZTz2sXNhIaNmTR+1220OF
 k+edLBweJ44qwgjEpqG+WskwW2H4PBV/9Bh4isaOekp0BcRjod4Q4jax5NWR6IcEwEc9
 m80Bfj6WD5Rd4NOohPyA6s0C2CF+a2TDtEkUr9YSuMUL72Zb5DRKU7Teef2q4AcxNCMy
 u+hQ==
X-Gm-Message-State: AOJu0YxIh3QOMDjXiNzPLd2/6LfSYktuK+hTNdxysZRwzwn8ZNd1ziMp
 RNUkgrhB7haJvtWJX5cD2fFWzbtz8fCsbeWSfFjXBkhQOhpvX+8CizVUNVPc/9fdgLnkWIKSX7o
 r3ew+Y7txGss+0Zo=
X-Received: by 2002:a05:620a:f0f:b0:76d:9234:1db4 with SMTP id
 v15-20020a05620a0f0f00b0076d92341db4mr11437002qkl.7.1700579029940; 
 Tue, 21 Nov 2023 07:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+BJPDNqfS+lWi8HQaclMvEZNHjXeOzz7T1KNArJfoO3o5UUtz5NQVeUNOXVQGE/hC06Qkiw==
X-Received: by 2002:a05:620a:f0f:b0:76d:9234:1db4 with SMTP id
 v15-20020a05620a0f0f00b0076d92341db4mr11436986qkl.7.1700579029675; 
 Tue, 21 Nov 2023 07:03:49 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 bm39-20020a05620a19a700b007740c0e52edsm3663745qkb.89.2023.11.21.07.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:03:48 -0800 (PST)
Date: Tue, 21 Nov 2023 10:03:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH-for-9.0 12/25] memory: Have
 memory_region_init_ram_from_file() handler return a boolean
Message-ID: <ZVzG0iDJ-voJ23Fo@x1n>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-13-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120213301.24349-13-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Nov 20, 2023 at 10:32:46PM +0100, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


