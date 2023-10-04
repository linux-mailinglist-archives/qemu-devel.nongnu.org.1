Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052BD7B809F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1l7-00022h-CW; Wed, 04 Oct 2023 09:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo1l4-00021b-6r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo1l2-0005TW-OW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696425463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=XVXpzsIjh9ukVuVIm8Qpjarlx6Tcu9yF0JYplPuXhgrZXAlmTuw/NyG0FwuUCy1hd9WAfu
 1zsfKe7nvWy6Zcq0ExuxIoR7uMnun5ouzMpbkutrB+soikr5VeURg/Lc4fLV1lztdAU159
 1wFUM10YAllWlZvhLDYR1IzrM6lbM4I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-xZEFVgiUMTaYUGhcOCq5og-1; Wed, 04 Oct 2023 09:17:42 -0400
X-MC-Unique: xZEFVgiUMTaYUGhcOCq5og-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993c2d9e496so185713866b.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696425461; x=1697030261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=muwKDbjX04mn9WAYZB72t8h8IgYZPrQrfdcrzsolfqG+j5Gtim88OQtNnMsNgcW7dN
 pe3I0csU0KZl990OjivJ9pFw8QQEKe/Wt+DfIoT9gGxg/UBqPtNRdXiP4eJvsQ/uwEqb
 01yC23pBqjjtzJGK9NMX1Zg/QWFPNJhl74FY2V1RfNqj0MhwxtsElpUg37CiVdghzQBJ
 Gw/tuqgV+T2+K9DsrIoerkFQ2riGqitnU2aNOgKWKrWk0muv+L+IEs37APf1b70TgMC2
 YG+eGfYMZ4BmQJVa0dCZ7Vkhmgpewo+oGzDxmC1mJaq5PXtxQwGqRx35bDLkbBLlC9uj
 dLwg==
X-Gm-Message-State: AOJu0YwyheeRSld2YZWfp7kL8b37SRmdVSk8vSzgc7bRDrc3ipvpU7qd
 TIBc1MqCpCGY+t8yiOMj1VECgy3e+2Gcwb1zWRxcy+PFthsISh4p2ikOBIP8ROEH5yzWOID9Y7Z
 7PukhJbbz/pxZihY=
X-Received: by 2002:a17:907:2704:b0:9ae:5492:64e with SMTP id
 w4-20020a170907270400b009ae5492064emr1764248ejk.25.1696425461213; 
 Wed, 04 Oct 2023 06:17:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHJZX6oTcIBM9BRZ/AFdY3r90J62ehFzhPBzz1JpDwXenCowv78rtXMCr59nUsIjWH10+QLA==
X-Received: by 2002:a17:907:2704:b0:9ae:5492:64e with SMTP id
 w4-20020a170907270400b009ae5492064emr1764233ejk.25.1696425460911; 
 Wed, 04 Oct 2023 06:17:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:2f4b:62da:3159:e077])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a1709064e9300b00988e953a586sm2774751eju.61.2023.10.04.06.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 06:17:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, groug@kaod.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] util/log: re-allow switching away from stderr log file
Date: Wed,  4 Oct 2023 15:17:39 +0200
Message-ID: <20231004131739.160561-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004124446.491481-1-f.ebner@proxmox.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


