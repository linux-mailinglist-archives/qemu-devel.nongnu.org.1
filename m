Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC771064B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 09:31:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q25RC-0002Gy-OP; Thu, 25 May 2023 03:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q25R8-0002G8-UV
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q25R7-00012j-A1
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684999860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=izaNKzx+afQ1aguYgWYucwLmQyDuknL+1ErpnhzjF+AFq/f7+tdVHtccFsP3iXyCy5LR3b
 qkqsYp1R7MTqqhmWOX+EH5iS6FbU0ZsLEnKnhLnAgpc0+wtQT+4RTdOo5yPccUzuOOoSeU
 94aA9u+CNEmvHY19S//ib2v2bcMgiQ0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-_UGtmhK2NKerTUh8-XAqEA-1; Thu, 25 May 2023 03:30:59 -0400
X-MC-Unique: _UGtmhK2NKerTUh8-XAqEA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f83b44939so29296966b.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 00:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684999858; x=1687591858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=XfLc25f2I/irzfnHk9W4H85eJt2r9i6KAlThYBerGNVjdLD5ZWit8zOpstwx9W6Oqt
 kWW/g6u0HKfKp3k80sxlSzB4V7Dr1tmEcQCkxP+bt1jrPK9bbHRtNjbSDb+NI2SUPZOY
 jpSxHFsq1wmf8B91Sn5Cy2x8NiCUtIvQB1m5gMYz7nOHhFPHHa2sjVo9gf8HVr56fwWJ
 9ndP4ltThoT99xvrVxaufPHQZuCbIEzY0L9LWDmwTVbIBIeiBZi0QKl3nXSROaIZWYSH
 jYbrFyVOxCBYqm0aEmxStt5pQqNQ38fP5bP5RVYs9GW8ivn7Wk23ML9z49d1UYefFdrk
 OKAQ==
X-Gm-Message-State: AC+VfDyOdwliKkPOi4Kh9xF2XiGFkM1eLNW8qIP+AZpeEkD2kdRFpY4w
 vSyr5T73tEZ92Pymv7O4dPlK66Ber5n1P7jgYTr+AW/PDtwQiAp2zLEN+SIzAhOEnN84cskh+Q7
 TlFwArLU0vxkYKKc=
X-Received: by 2002:a17:907:7b9b:b0:96f:9881:178b with SMTP id
 ne27-20020a1709077b9b00b0096f9881178bmr785321ejc.26.1684999858192; 
 Thu, 25 May 2023 00:30:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5GGdX2aHMtEIZQFbRjl0jw/8Yva31vUMibufiV6fDoX2O9Xvp9dVLG2a8BBx87zVaBQQ0IQA==
X-Received: by 2002:a17:907:7b9b:b0:96f:9881:178b with SMTP id
 ne27-20020a1709077b9b00b0096f9881178bmr785289ejc.26.1684999857802; 
 Thu, 25 May 2023 00:30:57 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a170906410400b00965a4350411sm452139ejk.9.2023.05.25.00.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:30:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru, babu.moger@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, xiaoyao.li@intel.com,
 mst@redhat.com
Subject: Re: [PATCH] target/i386: EPYC-Rome model without XSAVES
Date: Thu, 25 May 2023 09:30:56 +0200
Message-Id: <20230525073056.139621-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524213748.8918-1-davydov-max@yandex-team.ru>
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


