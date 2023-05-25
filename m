Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C802D7106D6
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q25v7-0001Wo-2K; Thu, 25 May 2023 04:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q25up-0001WB-Vl
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q25um-0007bc-5P
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685001698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=RzhBmC1bo0eTz6jUmVxyQSKcpfYLGHgihsGKfjKapvYIIpE9RT4riupq1PG2WWq2yM5fzy
 eca86+JVwt9BGuSR7J53Gaw7jht3xkZnObkhMTqTmYoWRt9OfLgkxa0ZdipWUHZ1zmFu98
 bJAGk6nBUxpZY1YllYNHBQvi6jJT8vw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-DBH_Gn0LORSlubRxiIqIow-1; Thu, 25 May 2023 04:01:36 -0400
X-MC-Unique: DBH_Gn0LORSlubRxiIqIow-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a341efd9aso43760366b.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 01:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685001695; x=1687593695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GKn92CsJ5h/RM1uJWLX/hYu53WUbds7kUGwVbRTLdI4PdXSRzG/mhUn7Xm/HgX+eVU
 uCiQhmpOuAbw3TVLL33GWyt8E3IxyK96Lb69iLYrxhkzO5kDXnmpgQMosYIXD4qZCCXN
 q9QrQT99DVBLxY6IF+b6ZSOMbJaOUovIVjsMUfu9yYVB7Tb5KFGCmHXSb4HqZC+DB41I
 WlVX83ySo/+k16UlDGVfFk3eM+bfhbNvC4fGtxZ3dl1gvMKVCbHFwTnHhLkxfpV4CTBC
 ODM5CRoZGWzA/mIZKlNJcNfkHUJ0YU89O6X0cCWZ0w/q1MLq0dLuyW9zSMAe+/0CbZlA
 4dVQ==
X-Gm-Message-State: AC+VfDyBJ9U9Avby3Rze/qT0MavPbqTBt0Vun3F4C4kvJ/uojxVDvda8
 85xMA3TJa4Lq6i8Px29Q3L2WX3J/lJDUPTAdIA3vUF6AMh7Kv9dWyddLrCpYfLTFVRzuH9fcsfo
 fnhE6lGJ2dJTj+Ro=
X-Received: by 2002:a17:907:d8a:b0:961:8d21:a471 with SMTP id
 go10-20020a1709070d8a00b009618d21a471mr993924ejc.58.1685001695046; 
 Thu, 25 May 2023 01:01:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6rEbrjyVoT4d+bJNhMrupzz65ITSg5hO2kM9qBNTSRBEU5al7U0zgTmRj9HPm7Wqu7ajBRSw==
X-Received: by 2002:a17:907:d8a:b0:961:8d21:a471 with SMTP id
 go10-20020a1709070d8a00b009618d21a471mr993888ejc.58.1685001694660; 
 Thu, 25 May 2023 01:01:34 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a170906118600b0094f282fc29asm474414eja.207.2023.05.25.01.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 01:01:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: pbonzini@redhat.com, philmd@linaro.org, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, hilmd@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] meson.build: Fix glib -Wno-unused-function workaround
Date: Thu, 25 May 2023 10:01:33 +0200
Message-Id: <20230525080133.142912-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524173123.66483-1-nsaenz@amazon.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


