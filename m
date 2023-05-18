Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 780EF708AA3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 23:38:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzlJO-0000TN-5D; Thu, 18 May 2023 17:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzlJL-0000T6-Nh
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzlJK-0007Ux-DF
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684445841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O+Srvw/68A6reDuCDiss1lPw0ZdWsEpcJl9oPDeB6fs=;
 b=a/xfj4nq4r5s9V3+M9iAuaiSJ1R9IkqnPca3/8Ww4s40ouHhtvXfpbFQuDsFmGcT5b/fGp
 kShrJ+w8BOf7FPZt8eLGZp/llq3Gk2MoD5dyxC3qvc8KNTsu11K1l72CLf1kIqQ+15LM/8
 +JHbHL9T4YB78dVZHJDK7PU0GjGxAvI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-jtw8UAtWOSS-IzP3qpCm7Q-1; Thu, 18 May 2023 17:37:20 -0400
X-MC-Unique: jtw8UAtWOSS-IzP3qpCm7Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f26157450aso1778187e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684445839; x=1687037839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+Srvw/68A6reDuCDiss1lPw0ZdWsEpcJl9oPDeB6fs=;
 b=FgvhWllh0sic6mRoTOJpdphVnIn25jswilKoNvu6aVpVgS1F/OBAorvESZ4hZCJahZ
 q0hl2H7cHhPH9RyCuYtfdZGl0Tw2VdcVgaySV48irT4DPEfvD6edMnH6RuwCYJtAmSg+
 PcIZAAcbOGaBajQoQWEn1C4lYHB/SzDpxYlfBdMJoFZpJxJLMSF+B1GbakMy/sBiQ+xR
 oS0jnsD8pq0LKUKJG5KpdDOEBknXMzg5w2qotaovynG4WcKu6bc0pzZoS1b4n8FwC3wV
 ZDg42KmwMflNjfM1GD9qDD/JQ530B81QirANjwERepMbhjisrxMXSAaleqy0IRXKW7B3
 s10Q==
X-Gm-Message-State: AC+VfDyxwQrFe90EMy3DbhKPdQuJRZvb2cPTGu2GzeXLhZk4uxrmpin1
 3IomW+p1Jq9/+Fw957cmysY9QlAxwOMoAo11iVFOLSuu4VmEYXuwUCz1ohXyPNhjd6nWg/NRvzv
 BbnNuzFmwy4niPjE=
X-Received: by 2002:ac2:484a:0:b0:4d5:a689:7f9d with SMTP id
 10-20020ac2484a000000b004d5a6897f9dmr72757lfy.57.1684445838953; 
 Thu, 18 May 2023 14:37:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5k2IGQwYPkS0w/3dS9uAjbm72d8qc30R49+Flx7B7FQMA+27AXVZJgHuvvV/jwEW2OL+FWyQ==
X-Received: by 2002:ac2:484a:0:b0:4d5:a689:7f9d with SMTP id
 10-20020ac2484a000000b004d5a6897f9dmr72751lfy.57.1684445838661; 
 Thu, 18 May 2023 14:37:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 j15-20020ac253af000000b004f160559d4asm365474lfh.183.2023.05.18.14.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 14:37:18 -0700 (PDT)
Date: Thu, 18 May 2023 17:37:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Cc: qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Anoob Joseph <anoobj@marvell.com>
Subject: Re: [PATCH v2] cryptodev-vhost-user: add asymmetric crypto support
Message-ID: <20230518173635-mutt-send-email-mst@kernel.org>
References: <20230514065519.2335265-1-gmuthukrishn@marvell.com>
 <20230516083139.2349744-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516083139.2349744-1-gmuthukrishn@marvell.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Pls do not v2 as reply to v1.
Start a new thread if you really want to reply to v1
with link to lore copy of v2.

-- 
MST


