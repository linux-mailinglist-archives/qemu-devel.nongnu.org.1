Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146B7CA55B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKos-00063V-TO; Mon, 16 Oct 2023 06:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsKn8-0005nr-Jw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsKmt-0002ob-Uo
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697451918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=TEB4QAVu+hNgXDpvcW0GBqYJTC+7VJzEaZqz0pZj2xxBzjuu0qtM0OIaj/rkbucn3TP7l9
 yTTIAXnthd1blxcva6UiyxqtjpP4ptQyAInVOT3H1ylKIlnieveaSCtngAGqrMop/F3x2f
 2DSqaqG4/bDK4Epijx2tSZC3RsRgzFY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-RTly-hq0MSOD1fISc_Yl8Q-1; Mon, 16 Oct 2023 06:25:11 -0400
X-MC-Unique: RTly-hq0MSOD1fISc_Yl8Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9c4485166beso48750566b.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 03:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697451910; x=1698056710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=NXagUAHckTGtUlk5+bgNPBY9YvC3kj7Qr63jMpBDG7oO8sjWQ1S+pTz9O1d8zbRc9L
 WdfIfqWnaUDpzrgjJZwO4Btwm2aM4OcK+cLIhYGGyr7nuHMyArecwNUeKLwIuF/5tMXW
 XpBgAgfiKYcUDRkik06+AogRRxZM7pJla21JN4WwNs3uXvfWVCSm6A58zmOAbxyfbBga
 Q2v/sDCbCxDV6QEG05KA/CLZauAWL6LsgSk85/KAKHmiwcud3cx3uw2Ttlvz+Np9zlND
 Ajcc4tyXATNxGlKwOPLBzIYdX95cNvUZ0g7cjNhVovTFteUljfdcqXetoP35khJqdm07
 a/hg==
X-Gm-Message-State: AOJu0Yzf4I3v7YswWrLNEy3S37VVkMMA2PkzwjaGgzoTY8Dn45aXOa+Y
 xO6NSj5i1rvj2ozuzdXjZq3QU1f0iryDHKB+OR7Aj0PqCppp+8taHW+M/LvwR1Wr+eaUXu87as/
 xLevjSH5QR/VRWN8=
X-Received: by 2002:a17:907:608e:b0:9be:ef46:6b9c with SMTP id
 ht14-20020a170907608e00b009beef466b9cmr5415438ejc.70.1697451910600; 
 Mon, 16 Oct 2023 03:25:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd6vtKP/leYs+rsI36lwvYZsKJVtokdagydZ4PZRX+GghwKJR7TPxkmT3rG+JX++S7PHc6dA==
X-Received: by 2002:a17:907:608e:b0:9be:ef46:6b9c with SMTP id
 ht14-20020a170907608e00b009beef466b9cmr5415417ejc.70.1697451910212; 
 Mon, 16 Oct 2023 03:25:10 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 vb7-20020a170907d04700b009b2ba067b37sm3637617ejc.202.2023.10.16.03.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 03:25:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] scripts: Mark feature_to_c.py as non-executable to fix a
 build issue
Date: Mon, 16 Oct 2023 12:25:07 +0200
Message-ID: <20231016102507.178489-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016094917.19044-1-thuth@redhat.com>
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


