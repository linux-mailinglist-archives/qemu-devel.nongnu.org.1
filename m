Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EA6B04C37
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 01:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSKm-0008AT-4K; Mon, 14 Jul 2025 19:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIX-00041D-Vx
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSIP-0005pu-Uu
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L5I3yMYEwmIpktuYyHjO4leVTXpIN1TMnMIOMG7LcDw=;
 b=SfPgkGyczTDqCJAl/M4Rcs/d+8hWtnzGFHM4JnlwMgHEdRMy4ljlmMpbZiFV0/Sb4XPAW5
 EZ4+Bcas/x/v6fPm1QsdSWQSlThazfUzvNVN5WdAIZI6Pq6+KQsfp5Rrlzwlkm3SNbvm9Q
 oOTXBCdbQxk1SoCy62VJOg4GtCAi5KY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-N6YyaPi4OOelYqEuW0zMTA-1; Mon, 14 Jul 2025 19:09:07 -0400
X-MC-Unique: N6YyaPi4OOelYqEuW0zMTA-1
X-Mimecast-MFC-AGG-ID: N6YyaPi4OOelYqEuW0zMTA_1752534546
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso2323879f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534546; x=1753139346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5I3yMYEwmIpktuYyHjO4leVTXpIN1TMnMIOMG7LcDw=;
 b=gBvQaE8mX9Dwc1f/59XL9zJlY5SUwKukYzqGXMliVzX6lu01NYfNSuy8xZn0iXzUaG
 vj/DG364HYt9YfSzHIwmDwd+jZjAi/2Qvi0aEj6Qcuw+q3dDS9flAG3RY4Giqn+/Gm+N
 ii3xbyLGQn9O2L2Iyg/uNHaVg1YjKx2NiG76QZpZO/ctmcFEyu2tvEvkhpfap3ske9Kn
 Yh9ynDV+tk8j69gsMxbcc0eEg9N9whQOEieR4XSerJgIoxl+GeMcoJjT3DVtlZ26vZDK
 m2eVdIZI9YhhjllA+VX3wfN41v74XfAbZNIkKCipT0jyxNr501qZVnsZtOULHkZOY6Xs
 jv6A==
X-Gm-Message-State: AOJu0Yzz5/OjyEcNCkhChz+Ymzw7ml6GpgVJvtFkls4x5BPCTX52gHBu
 J6i0tZAcW5sqnZrLCkw9uYquNPTg2d9fYld1X7CvRzoYepirmCg1witqStvqVNyGxiMJQLU7hfb
 A/c8xtTm3uH0NYX7a7uYgynlQHtsBOVCmQSs+BJeUw/KEIKnsBeKPQ95Q7xXmlGXKfIbdMjSVsL
 qeWsRSAX3zBpny1X6bW7j1js/9JZ6NdbWB3A==
X-Gm-Gg: ASbGnctoFX/w57f9SBg1BpmaY9gUcA0vo6LCZG3SalAtGJIE05Z+AnqFRRLyk5CkGa5
 7AkmI18wdqZdZ5GkOVnQzOKHKuxKlt+r/8I26GaETCG425fn8/T61L2FoGQ1UWgFzAZQoDw9xMe
 Bft+tP08B+DchTlc4Ti4iGl4yTsgMtKzdLzY5NftUvjx60miT+dP33p1bvOwBoKGV6cIhAXXx1R
 bHQK2Vx+JI/S7YgEDiBnBd7LwnmWxRli9i45pOk15+zq3+VObpHU3Z8ffzXP7eovmxSvnQji8x4
 3f1cRek/efwpvIfWb/K4jyGXW4heofns
X-Received: by 2002:a05:6000:288a:b0:3a3:7ba5:9618 with SMTP id
 ffacd0b85a97d-3b5f35784femr9088560f8f.29.1752534545848; 
 Mon, 14 Jul 2025 16:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5e0euedvw7HqhCPvlxbYNuGFiaIDKENpttdy3ZwWvfDouvpH5mIIRGgHxULZSAM+1eGhY/w==
X-Received: by 2002:a05:6000:288a:b0:3a3:7ba5:9618 with SMTP id
 ffacd0b85a97d-3b5f35784femr9088544f8f.29.1752534545332; 
 Mon, 14 Jul 2025 16:09:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc91d8sm13318599f8f.42.2025.07.14.16.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:05 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 65/97] qtest/bios-tables-test: Generate DSDT.viot
Message-ID: <119c454da2529a529628ec04a52200a3e7058f31.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Use a specific DSDT.viot reference blob instead of relying on
the default DSDT blob. The content is unchanged.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250714080639.2525563-20-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/aarch64/virt/DSDT.viot      | Bin 0 -> 5158 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 7a74beab3d..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT.viot",
diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..acab6e65febbc210158d4c39be0680bbb90250f5 100644
GIT binary patch
literal 5158
zcmZvg%WoT16o=2)6MH;<Wc*0%I8N+Bsd!dnyJ^zWmfB+{aj_HQNgE_rawJql$)*w&
zQmK&AELzBpMq(YL{vk-LkXW!|(KQ?X0d^SOc{t~%o>|y)ALqOG8=sMmZ^!NIT`CYo
z{%G$y+itD>`OvA=YBi0B)V=z)p54~&Pu%uod|Y;H+cqZKy-vF2412b1uahyk+w0Ky
z_`0(@2**Z)ZQHKbgE3>`jNEM5EIv<=0w%~J`Y}eDc7ceV(D-;`bKlwYxu10hcWv8l
zkTG%hT4vIiI8ICR5m__iBO-}X5ZTi2jlwPUcSgImZLgg#JBvJD+@wgbxXlrDe|1Et
zW#2$V7@{5^+G-aK31LPghRzrb&S;8^sKkgdMw2tHhzwm~7>sd+GuA}LoWw90V~sPe
zij0`VNHNA$&R7>2afy*(jCIb~5E+KVuoz>5Gp>n@gv7`(#x=&M2QLSvm}yFk0%Kg~
z3^7gdB?(h~kug5z3^`9z(mqOzaf37DJWWfCGGpB23^`9T5~IQxw>U%2(|L)p${3$;
zhMcFC#HcaGZO)MMG%GRQVvH7N$a$KR7#A6%%^7l@<|W1@#&8&;A?Im9V!X>39nO&R
zbU|Xg&lp|Kkn?m=VtmLLo17u%X;ETaW{fS)kn^-8F>J=z<_tMcmn24mF?yUK=V@7D
zTw#nmoFV7wvc$N`7@u;6oTn9uvB4O9&XDtTMPgiMi~(ab<vd-L7&jPWhco0ntxAkr
zjIkRqdU}6W5Dj;RwqtM3ijU#Q&1TG`SLeL#&G(BK>?_13?#R`~J}TG_pfm$e7X_5x
zH$&Y~y9(YOK&fJcZ|fa_<@X^gc#Dt~Mb;&O<@cSlUJjjJ@T)0S%id7Wq}K^rO;z)C
zx5${Z+dH%8=<bcORkJcAhkEpYYGhN5I`n|PrHAwdJs?sLuS^?`_VWF2%%faVPfn+#
zejD=dwZ3iFDVI|HW<))nuo3Osc9U{xJvE(bq+;r`mWpanF5{1Ran19linN2d5ihba
zYpKX^YQ&GUgUASZk>M&)FEZRg)Qb$KM*YZo5E=C&!&P)IGTedgMTS##KQi3B?nj2J
z%z@_|c+R2coF5sk5(Cc|c*f8(hMsZojDu$!J>%$UfTsbT26`IknE=lOcqY&@fu1IK
zn&4@or-`0P@Jxbd5<QdXnF7xgc&5-Zg`R2fOoL|{J=5r!0nZG0X3#T(p7Y>251#Yr
zIgg$ecv|3Tp{IqOS@6t)XBIuP=$Ql09C+r?Gl!me@XUi}9zFBuSpd%hcoxvJfSwEB
zxd5IE=(&KNi{QBko{Q+Yh@M68EP`hdJ&WjB0?!h7me8|=o=f1l1fEOixrCl&@GOI8
z89mGBxeT7m;JJ*R%jj7F&kA@}(6fS`E8w{To-63Nf}X43xeA`E=(&oXRq(8WXB9oG
zp=ZIGIPDg_%BWKx_5a4NShnNl;~&x#Ns+py>O*@`Buc5n9CcaK>3`~PnHs(PqDWdQ
z>bHod-t_4$B8^TyU@_ix<jt7+lh~#DpHQJ6pX|DhesV}oXTN^7Gk5w`Hg8(v!RzL~
z)ynOk_aC=@z4_OdCx@o)boLu3ho<3l_M4B?$HCJBvwCo5y*z!WeXqj3vHDs5<*7I9
z_gQM>(ShpuCFOT1RQ=Uq;iE~%9q4Bl{5Ahv|NU=w?YqHG#eW7%zd3`m#Oc@cDjU@_
z^+Ds~fj;WGthjN!BP@0B)imul%)O^OoldLjDYMH`_v%Ef9lw8Bow;pwI}`ux!9Q@T
zt0L)cuan;DcA%h)YVY}>N8M3(i&8{J!qmsllB(%+-EO~DSebP1?Ij+m#=)6&`t-n5
ZwaN40{-|vpjgObqjlY;*>N!CX_CM8!>@ENR

literal 0
HcmV?d00001

-- 
MST


