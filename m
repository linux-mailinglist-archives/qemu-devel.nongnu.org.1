Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AAF712584
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:32:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Vg3-0000I8-5I; Fri, 26 May 2023 07:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Vf8-0007gx-ST
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Vf6-0004C9-2E
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685100671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=MvRMcWkh5JihQ1+03GLMepuFwbDgffiTKj+Zy5xsy3CgX/S3SOyW1EfpcFBy/85hOIee3h
 w8x3ACiEkNhlwV0fBDsZIiR1kaGSpL0+KYFOVVO4Cnk6TPxcQpJ3xkMRfD5hcQk9Gaqg6x
 NMtD2MK5viprTLuaVpAZeMQnFnB1Aas=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-bREhDU0aPfWoO32JS_wFUQ-1; Fri, 26 May 2023 07:31:10 -0400
X-MC-Unique: bREhDU0aPfWoO32JS_wFUQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5147d242f01so370184a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 04:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685100668; x=1687692668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=KOIIQOTFugQefB9MQrfr2aLfAN0cNGTlA9UE7UpHralNjE0xvLbeenYCTHxLtOWLW/
 LAAy0ExLePMAopJAqGdTASAT1zdzIKbe+7Y8VPHlWida6J3imfegRfBCHlC6W18KSrdu
 hRHIsw3YX35ipGAJofzkYMu83njteQV4el4Naqyktxd30DaexciYtgNp9NFI0j8YzXLA
 5bnY0WNcbt53C7URHSCNPFqA37HLwvaTKIVx7D1HsUtomYAxQUUB8HqrCJGmTygKHjzd
 zFThGEXtWS40Cg09o1Ecf6G0AmX1AokeytkkVa/HMIVySicx+a+rtZph7PQSpGwoxywX
 yLLA==
X-Gm-Message-State: AC+VfDwWrg5ksZgzDyTLlaa2bNciX3RM75tVO7ny+/QBbdhJF46O9wTN
 FGPZ4cToPtceTTn7/bgqFy/BkYU/t3OH47WBmqYDkb4oI/qmnk+2YSZ7nK/A9onZ1LwRQMxpAVz
 f5LtU89dwrUe/cpvCNnv80LY=
X-Received: by 2002:a05:6402:270f:b0:50b:2088:3533 with SMTP id
 y15-20020a056402270f00b0050b20883533mr5545538edd.1.1685100668389; 
 Fri, 26 May 2023 04:31:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PsOQq+1ecl7Ay2GAQfyf23IddrR49/A7cUmiLAuI6HSWW7PXb+Hos91BPTFgjH27iX5F6ng==
X-Received: by 2002:a05:6402:270f:b0:50b:2088:3533 with SMTP id
 y15-20020a056402270f00b0050b20883533mr5545528edd.1.1685100668056; 
 Fri, 26 May 2023 04:31:08 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a056402075400b0050d988bf956sm1484595edy.45.2023.05.26.04.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 04:31:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] meson: Fix initrd-stress.img build
Date: Fri, 26 May 2023 10:19:21 +0200
Message-Id: <20230526081921.423544-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525212044.30222-1-farosas@suse.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Queued, thanks.

Paolo


