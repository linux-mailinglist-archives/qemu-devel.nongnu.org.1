Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D86D9745D8
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 00:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9BH-0007Ao-MS; Tue, 10 Sep 2024 18:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9Ae-0002Om-PS
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9Ac-0006s6-Sz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:12 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-717911ef035so4712341b3a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006629; x=1726611429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCGVOkz/BgjMXg0ik5e1jthdc26fdQDBLF+1lu12foY=;
 b=MlV6jPinbs7SXe7cvmnOtMJtH8OdH/tWWebrg2gJZDVeLJJENpf6/HHp62+B+qGvZD
 tCcUd2ll14hr2xVSK7vLI5sevb23wt1ED9RfgndZfsH1RSSQwaGaj539F9EzCIPirqvL
 opY7Lu1HOio/IWWK3cGB3e8RP+WMjnJbehoTcqB/hKTTf3VPwCrZxFMCLDvuqMdiMi6B
 IwU0RMdoTjMN0bt9jvK69WmaIY13bAZFChNmveWJuJxdhJNV0T54i3mM6FmI+yEr3Gec
 rtZ774NZV0B687NrHoGFfDDtjs+BbULgxibiKtLLlkWSTm/cfWUnYz0JBdJzQPj+RoMg
 4MpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006629; x=1726611429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCGVOkz/BgjMXg0ik5e1jthdc26fdQDBLF+1lu12foY=;
 b=MLh46nt/ixGxkU0kawwByTsBiDr85oc5OEJtRfuMm9J0uatFQ5KP6z/VwVGZUL8zVl
 Cnel5R/VlYLShQiLaxoej7Hf1AiGCctMiMCFkMBgXpV9LFE1Oo17QTYwyoLKH2HU0i/T
 mxGHS7MKhaAQQB0NcbIm8m6i/jAcNgybYMpWeMwhfOza/+cC1EZMtHh+spKDB9HgykoC
 wp5Marjhu2OCRCM+RPSOQGBT+k8oL4qsMzeb3fGrKP0zOE9tsTNpAs/4L4K+hknnt19Q
 w5m7kPIZyXtE3IhctgfDAOpQ+EGSH7c8fva61LUXJjIdZOa6ozzEKGcceSmc8ypU7kC1
 Nwbw==
X-Gm-Message-State: AOJu0Yz1GpE0GcGcZSgHi7YyO5WkpRXgcmeZXipmDiozlKDo+66ll3vs
 LWG8FfHZfWrCJnGYkt8DrzAWuVbP5MS3/XN9XGCeCFKyfgVSyDqqDepmhLEXnvDgMp8uJFHYoRJ
 2WDT7LgS0
X-Google-Smtp-Source: AGHT+IGi72IfaYUiCGQt7lWSGV2AP/QNzvbmyXN6XQj5zV/aN0oGXhyf4mxvjQxKuaGQQoLA5lFr1g==
X-Received: by 2002:a05:6a21:6e41:b0:1cf:5437:e768 with SMTP id
 adf61e73a8af0-1cf5e03316emr3202667637.7.1726006629425; 
 Tue, 10 Sep 2024 15:17:09 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:17:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 25/39] block: remove break after g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:15:52 -0700
Message-Id: <20240910221606.1817478-26-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 block/ssh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/ssh.c b/block/ssh.c
index 27d582e0e3d..871e1d47534 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -474,7 +474,6 @@ static int check_host_key(BDRVSSHState *s, SshHostKeyCheck *hkc, Error **errp)
                                        errp);
         }
         g_assert_not_reached();
-        break;
     case SSH_HOST_KEY_CHECK_MODE_KNOWN_HOSTS:
         return check_host_key_knownhosts(s, errp);
     default:
-- 
2.39.2


