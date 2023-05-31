Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C517185C7
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NS7-0002D3-KM; Wed, 31 May 2023 11:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NS5-0002CR-QB
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NS2-0004D8-Rm
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685545728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=82+E05NEJaSZFJYLuV5eK0dcfbNXYsn75+wq2gqKti8=;
 b=QVbCmUbBFTKijiKo9+jzbAd/BZ0MAswj4LSzcZzT9eEc6SR4ujqKrZc454uC+tF2VMXK03
 MEfCZ8CQUbOisqvFdVRwSDRnr9UIT9wuRDh7yLY/mDl1aJh+fdpx6Yw0Y3HZwyQTsFzl95
 8ooZ28LXvQG6ajp0aTmP/tqm2OOqWeA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-e--DHv2IN6qZjlSjcoRikA-1; Wed, 31 May 2023 11:08:47 -0400
X-MC-Unique: e--DHv2IN6qZjlSjcoRikA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30634323dfeso2621180f8f.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685545725; x=1688137725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=82+E05NEJaSZFJYLuV5eK0dcfbNXYsn75+wq2gqKti8=;
 b=NkRMWIdpLZrVruJqWfHDyrN5ExoLmFDQ5M6raAT9PltlAvZ2OnmIUOU6ORrtlXx3zX
 eJ9o2qqqzV3F9uUu2ZUDvmAAQ9fRuz77WokItYr4FyTq3cld2pi/cd4Y/l6FtXkZzaal
 F6UF2YeEvL3jIw0PpfLiivlgJL+ObhXQ4TPDrEMJs2E15rhNDIYb547xyHsU/j1lZvFz
 Q+bY/x4ltUeoBjxxb/kXfVRm8fPTstqwMVsXoHAMol0D1O4OgmJy/9XDetChJaGB4eof
 GRcDstApnGBGtGV6g4ZeQzXOrbxsRRrtGgHH8xnW1/tDdPtAsxTcvlncz7BWYFns16D4
 6pQA==
X-Gm-Message-State: AC+VfDz1RW0CRzM8JDJycSIPm7iz8lkBfcF6R5uET17cn09SVpTblerY
 QKQrh/EJ0QmhhbGIrMXYhZcjCLR5DBYSLcnOGhZ28vCtXPcYmHMOJpyJCUTCLCKGxGA4B1oWleo
 /MkuNhxTdQYrlu3ReiR0Ltqx3/eQYrtfSIQayMeJ/swqqZvuMKLMH43H+J0sNLcO/DwYmyeT2
X-Received: by 2002:a5d:5383:0:b0:307:83a4:3d3b with SMTP id
 d3-20020a5d5383000000b0030783a43d3bmr4530659wrv.54.1685545725865; 
 Wed, 31 May 2023 08:08:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ68u36qecBYu948Op47P4IxyFaKQu3MVYsCGJb6yDAOLCb+9JJfBR5EFhlbhwVJkwwDB1p/VQ==
X-Received: by 2002:a5d:5383:0:b0:307:83a4:3d3b with SMTP id
 d3-20020a5d5383000000b0030783a43d3bmr4530646wrv.54.1685545725593; 
 Wed, 31 May 2023 08:08:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 g15-20020adff40f000000b00307972e46fasm7090499wro.107.2023.05.31.08.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:08:45 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org, alex.bennee@linaro.org
Subject: Improvements to Gitlab CI container builds
Date: Wed, 31 May 2023 16:08:19 +0100
Message-Id: <20230531150824.32349-1-cconte@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

Given my recent deep-dive in this part of the Gitlab CI, I
figured I could propose some improvements that came to mind
along the way.

The last patch removes the need for Docker in Docker.



