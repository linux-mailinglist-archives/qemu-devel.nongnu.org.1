Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0757AFB69
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 08:53:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlOPs-0003kC-Hl; Wed, 27 Sep 2023 02:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlOPo-0003jz-Bn
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlOPl-0001ya-EK
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695797572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dP3d7f4x6H6FJcgdwqWXpuEMtrju2NTUHowPMFgoclGphuu0qeeVOc1YalL+aQuFFf5y0A
 33eCEkKzUL6XlOUkYm0T3ZGbc5VB3+DlpGpqIFu0NdhRzkgNSQ1A8HnG9TVKFS+0hg5OME
 +P2HLx47+reIFP9jSs6pPiDCZhCLXyg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-HCKbrBOuOUWZ584WHM5wjQ-1; Wed, 27 Sep 2023 02:52:51 -0400
X-MC-Unique: HCKbrBOuOUWZ584WHM5wjQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-503269edbb3so14707821e87.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 23:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695797569; x=1696402369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=YiqKVmTgKtMfKnW4gMePZ7xxUtBlhqUgXzjmLncN74zszSCLPsiSk7Jg/RFbyhqL4V
 0/D7T3oYIfUQeYD7mhbYhi54RKZfs2DYfhs7Z9gLn5kLDpUM9GkusTcRuxuanvJPb9PV
 NvJ45vmJVd3ylb2wVlxHCqKLq8a+9MK2R071kNTGxrmFVc2xVBRIpqmfH7t42H2xH4WY
 Iq5MzgKNPN+VIcZ3RkKfu584YuPpj+lqjK6NPY1pJywt+H7iN1T8yd8fXRMTkN5jgxwR
 DqlmqWbJ4YNngxcjKAG4BfqArENj1lxT4NNLq3i+nFGK33Yip92aLMZokNHb9ALxDCFv
 sN/Q==
X-Gm-Message-State: AOJu0YzLDhHSMu4VEFOaihX6lC4cOKwvjG3fRPeZ7/Zb1q1WkTCnpPuT
 dDHN8uVBcsFv61GQk69WlfaUI/fTDstwXop+J0/UVdQN2bad5YAbdQ6nqRJncD70liDSgnPjyLp
 cBa964r/EBC0awlc=
X-Received: by 2002:a05:6512:4028:b0:500:b56d:e11a with SMTP id
 br40-20020a056512402800b00500b56de11amr977790lfb.43.1695797569719; 
 Tue, 26 Sep 2023 23:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1I5DvFBuAhubq7r0NSLTOSVhcXoZXEQAPIBjVC71Cc4CeMGvBRXYv9KgfxITomnThC92Vqw==
X-Received: by 2002:a05:6512:4028:b0:500:b56d:e11a with SMTP id
 br40-20020a056512402800b00500b56de11amr977777lfb.43.1695797569363; 
 Tue, 26 Sep 2023 23:52:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 ck15-20020a0564021c0f00b005342fa19070sm2887178edb.89.2023.09.26.23.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 23:52:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Dario Faggioli <dfaggioli@suse.com>,
 Vasiliy Ulyanov <vulyanov@suse.de>
Subject: Re: [PATCH] optionrom: Remove build-id section
Date: Wed, 27 Sep 2023 08:52:46 +0200
Message-ID: <20230927065247.748219-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926192502.15986-1-farosas@suse.de>
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


