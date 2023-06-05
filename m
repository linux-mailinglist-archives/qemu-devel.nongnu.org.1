Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 670FD722100
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:28:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65Yz-000576-Pe; Mon, 05 Jun 2023 04:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q65Yx-00056l-Db
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q65Yw-00070h-0c
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685953656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ijXf90P6GZXayAfBzPBf8eXKNO9Ztfe4gLBK1ZdGZxKh7mBF8CXnhHg1y+zPh+3lkUR+wj
 XKDWiruYwumUvdNneXQESaAX4bHKtyA3iDD+606JngFsnHfyXuPVh4DaafCPZ+wdceI62L
 hHAeDE5Lgad/oJhxdWATZ2sO0uCt65E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-YYrafCp4Oq6W-Y4sFsZGHg-1; Mon, 05 Jun 2023 04:27:35 -0400
X-MC-Unique: YYrafCp4Oq6W-Y4sFsZGHg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9715654ab36so323046366b.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 01:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685953654; x=1688545654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=lu24CZaXGEpnVXfACHQSaqiW8F2JtSIZdpYHbO2CVEmBud2Jgb7m7jRU72GYXzUgAQ
 s/nrIr6U0Wtt25C9TTfZtXt13YU/uneg1Z0F3Lpy4KKVWuOyfXJq5Y3sGMxKn9K7i8Fs
 v7MeUjpG+7FJtgbYItIBjqfG3WI3su1RhYZC5uyD7RxrXnGq9C9BPY92aqVZzSkCBqp5
 fspkJmiUixwaBRQ8jehvQ/XZ16GWj0+mMP76Y8j+TETswfeDKF3OclxIDX+ELX1l1ha9
 EuliTWCBPIyhOooDE8s4fz3gPyh3Q+IEO+00Km66lSOD6lpBt5wSjYrSP8G19AfHS3Eb
 UCwg==
X-Gm-Message-State: AC+VfDwtmhdoX8WFgXOOtSUXqOMxorXg93ubvXj5ngTiKcYHvok3GMgo
 wmgu9kZv8V95UjQ2YS2LTnl5Co1XBkI14XtfngVr4S6dYtT7anCPpJBcD/8Dk4L3C6BW0EmoFAR
 aWGzCWsSeI2QOVYs=
X-Received: by 2002:a17:907:6d86:b0:96a:4f89:3916 with SMTP id
 sb6-20020a1709076d8600b0096a4f893916mr5370094ejc.58.1685953653980; 
 Mon, 05 Jun 2023 01:27:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7fwun7+SLrCTheMkKwzAxDFT+ljNN45szDbrK3X/Y3v/f3Y3wjouvT3PmtmgBZ1YnMH2UsiA==
X-Received: by 2002:a17:907:6d86:b0:96a:4f89:3916 with SMTP id
 sb6-20020a1709076d8600b0096a4f893916mr5370076ejc.58.1685953653184; 
 Mon, 05 Jun 2023 01:27:33 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a170906869300b0097461a7ebdcsm3958991ejx.82.2023.06.05.01.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 01:27:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] meson.build: Group some entries in separate summary
 sections
Date: Mon,  5 Jun 2023 10:27:30 +0200
Message-Id: <20230605082730.53907-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602171832.533739-1-thuth@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Queued, thanks.

Paolo


