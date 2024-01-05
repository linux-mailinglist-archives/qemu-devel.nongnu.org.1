Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB154824CAE
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 03:01:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLZVS-0008FF-HO; Thu, 04 Jan 2024 21:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLZVN-0008Ex-8k
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 21:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLZVK-0000RU-QZ
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 21:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704420008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtCv3rNm2RUDU2XtxQjOEj0rRO+vmF56i+EJz24VM3I=;
 b=ZutZF9TntbR8nclHUQRH/gxFBAqQUtbHNqxFfdPnyvri0ymfCWiIuvVybJJIeX38hLFzSA
 EEgfXoWnQH61qv6mEdTTDmmwyXdOF4upzJSg3dppcDtbZP8fDYgqVTLTMO/C5tdUJZf1B4
 H/+Sgim5m//jyIx2JiEJDLcLbzM/hWw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-V_Q-XbRuMQa-rwd2AEgNjg-1; Thu, 04 Jan 2024 21:00:07 -0500
X-MC-Unique: V_Q-XbRuMQa-rwd2AEgNjg-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6d9b96ae87bso237217b3a.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 18:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704420006; x=1705024806;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LtCv3rNm2RUDU2XtxQjOEj0rRO+vmF56i+EJz24VM3I=;
 b=HGV8zycA1HGCITIt5KXXNDq9PZ0IRqOknezDIifjHo9X6Jeu19Y3HzD1QReOP7b9yc
 KbDgRMSl2cFow9RTYBiGjDTXkqkyvk9nSLWQM4bECzI7iyxTdXZUnsdxzV5DrFs9hPxw
 D4oEBNGtrnjJNMbT8ThZDyxAtgSE8SEEwAnrDWHMd5UveWMUpI1s2SHInRSK1Mk3VSTk
 tDGHcHhF5y/z9YeNKDgWaG0g5ropJF9+qhinyGCdvt8gSRCO+QGG2OJ2lnrRIV2QM8sH
 Iv1KIpxjvig6Xw9hil4eQxx3kyLSQeZTZEWwa2pIbV6Lpvr3PByTIUFOQwCKXLv9LL1H
 vhrg==
X-Gm-Message-State: AOJu0Yz5M4s4TDOfKBVF0Jn6kiGsQKJRlAtV6kGG7xJm+CNyMsfevVZn
 ELeCrCTVU/ji9ICa5JUcmlolubsdVOBFGygZtXseZ4wS5DWWG4Q2FjLE0Kg/eLQ99mNHhLKkiuQ
 v1SYzVPk7bQUhhL8k55ZKPTc=
X-Received: by 2002:a05:6a20:1b1c:b0:195:2e78:d4f6 with SMTP id
 ch28-20020a056a201b1c00b001952e78d4f6mr2314937pzb.1.1704420006089; 
 Thu, 04 Jan 2024 18:00:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMb23Ny6y/RWUFSEwgbDenRgVXHyHL1DsNRtc/jAd+W0PNE9Thewn4q+r9YPiVpKAJV3sfQg==
X-Received: by 2002:a05:6a20:1b1c:b0:195:2e78:d4f6 with SMTP id
 ch28-20020a056a201b1c00b001952e78d4f6mr2314910pzb.1.1704420005503; 
 Thu, 04 Jan 2024 18:00:05 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s127-20020a625e85000000b006d842c1eb6fsm320651pfb.210.2024.01.04.18.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 18:00:05 -0800 (PST)
Date: Fri, 5 Jan 2024 09:59:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] hw/audio/sb16: Do not migrate qdev properties
Message-ID: <ZZdinF59FrEJDhhZ@x1n>
References: <20231124182615.94943-1-philmd@linaro.org>
 <48dcbec1-dceb-4bfe-8876-96b99c8ed6c7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48dcbec1-dceb-4bfe-8876-96b99c8ed6c7@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

On Thu, Jan 04, 2024 at 05:48:18PM +0100, Philippe Mathieu-Daudé wrote:
> If there are no objections I'll queue this patch (fixing
> the typo reported by Zoltan).

Yes feel free to.  Thanks,

-- 
Peter Xu


