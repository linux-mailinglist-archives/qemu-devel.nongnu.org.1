Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 569707F9F91
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 13:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7akX-0001xa-C7; Mon, 27 Nov 2023 07:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1r7akU-0001vQ-KI
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 07:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1r7akS-00084T-0c
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 07:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701088198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=G7VnlTa/mYqucyexm0LB6VeTp/sOa88BU2XfhVLXw1E=;
 b=hJ7y4wiNiBw6+Gl8Vu0ATbtks+LtcePZFr9BMdMhd3uqZcUJxzxLlZHtG34aElnsjElMsj
 ujFcXWirDD4X8xgEBrrLF1nAz/PHvdw6Ks2cE1yJbq2aBSshfiPnqQTlEVxZ2ox1ZOvUor
 Z9s/QU2dv5pxPAgLAgx1ue33m1KyP2s=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-aS8qWd56MQOp3KkX07s8BA-1; Mon, 27 Nov 2023 07:29:57 -0500
X-MC-Unique: aS8qWd56MQOp3KkX07s8BA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6d646a0d9bfso4407351a34.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 04:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701088195; x=1701692995;
 h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G7VnlTa/mYqucyexm0LB6VeTp/sOa88BU2XfhVLXw1E=;
 b=tdHDEWdMGzNn1zGlKby4ubkBAmvr5vg31cGlyM7t03QHZm5IgCf33qYSsFByOPAWXZ
 kErC9k8McadqWqp75zEdzwqIeb0+w+rgzDxHkib5mTTBbvKU+KGWcbR89ehGbIr7dIv8
 6b6kSY+MWVUo8OqUUi6TAXqb1z/o+XCSi3b7P20eUk3vAv4fsP+ISQH0wHEhbcLlRb6H
 uDig9RSXQ53vlr+YYc6/c1hpXtveVMRbDp9pWFBgqlIoc+DZluK1POuyqig+dyyEhyTg
 NZjp25J3W6pAIrIHsUfmHu3JNkZM76hNDyhmcyy4FclohUe1TFEjqE00x9uHYlK9qNqM
 XVgA==
X-Gm-Message-State: AOJu0Yzjv7i4U2QHwYA/4qRDJL2UBnxzNnFuR93tbf6rVmA5Yg8aZDM4
 LSnGEmD6nwrdaKh4QhT2S+W86jwwyLHzpq3PNZm7qObV3dMk9V5kdTxZvRZX69rAzMb7OKBeskn
 9QvvYF6w3kKmFMamX3AtOdcTESqooEG0z23bhY3TiwtFgy1bC8OSL/0fux5TO6MOVJ8HzyDMS
X-Received: by 2002:a05:6830:448d:b0:6d8:1c4b:6c0e with SMTP id
 r13-20020a056830448d00b006d81c4b6c0emr6746117otv.9.1701088195739; 
 Mon, 27 Nov 2023 04:29:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER2SdbRRYyOPgvJvQYyu+1YLOr5Vr/X96TShaQKe4Pj76cZg5gyt2fMTYvBAkrLd031U5PdA==
X-Received: by 2002:a05:6830:448d:b0:6d8:1c4b:6c0e with SMTP id
 r13-20020a056830448d00b006d81c4b6c0emr6746097otv.9.1701088195484; 
 Mon, 27 Nov 2023 04:29:55 -0800 (PST)
Received: from rh (p200300c93f306f0016d68197cd5f6027.dip0.t-ipconnect.de.
 [2003:c9:3f30:6f00:16d6:8197:cd5f:6027])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a0cf0cc000000b00677f34c4b4fsm1563904qvl.6.2023.11.27.04.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 04:29:55 -0800 (PST)
Date: Mon, 27 Nov 2023 13:29:51 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: qemu-devel@nongnu.org
cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: hanging process with commit 69562648f9 ("vl: revert behaviour for
 -display none")
Message-ID: <392b2fb5-1747-0f73-826f-b410cdc84f07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hej,

qemu fails to start a guest using the following command (the process just
hangs): qemu-system-aarch64 -machine virt -cpu host -smp 4 -m 8192 
-kernel /boot/vmlinuz-6.7.0-rc1 -initrd ~/basic.img -append "root=/dev/ram 
console=ttyAMA0" -enable-kvm -device virtio-gpu,hostmem=2G -display none

..which I've used to debug a potential virtio-gpu issue. Bisect points to
69562648f9 ("vl: revert behaviour for -display none")

Is that qemu cmd just invalid and shouldn't have worked in the first
place?

Sebastian


