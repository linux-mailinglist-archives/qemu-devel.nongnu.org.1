Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E2802CFC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:19:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA49Q-0003xB-92; Mon, 04 Dec 2023 03:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rA49I-0003wK-9g; Mon, 04 Dec 2023 03:17:52 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rA49F-0008Ln-Hd; Mon, 04 Dec 2023 03:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701677870; x=1733213870;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sDTLmkyzQ+lNPezqK369KVJFY1U9DKxyrI2uwpw47sY=;
 b=QLzM+IR3njx7MH4+IH0M1H391Ra1nBP4UnbBH+xbgI+KB7RcUpGN53zr
 4kyRNGAQ8hGhrbXbmmOJLdlQIbYka0dXAHJALu8HXjVgrGysvJpTIRKpN
 P0Wj+80S5MTvglpXjTPsF1v9p/abc1+2ApTKCIFWfjOm0kKLiwyyuITmM
 Aq6WvetuZPJO7Vjngqrkm/vpi0cgUVpPvOHQaErywclVFTiuXqQ1cNEOc
 c9HVDSHjv7p5GixFmjf365Vzy66UoKlGYrs6HKKkNskmEcq09XSNA5soT
 z1m0WWQOG3nS++FCI35zPF8gB5FxWhAJQeKZYzkHKHIpJLo3EYnPjfoDn w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="581604"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="581604"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 00:17:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="804829711"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="804829711"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 04 Dec 2023 00:17:16 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 3/3] scripts/spelling: Add common spelling mistakes in default
 spelling.txt
Date: Mon,  4 Dec 2023 16:29:17 +0800
Message-Id: <20231204082917.2430223-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204082917.2430223-1-zhao1.liu@linux.intel.com>
References: <20231204082917.2430223-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Select the typos in commits from 7.0.0 to 8.2.0-rc2 that were typed more
than three times to add to the default dictionary selling.txt.

The typos were counted by (Referenced Kees' command in Linux kernel's
commit 66b47b4a9dad00):

$ git log --format='%H' v7.0.0..v8.2.0-rc2 | \
   while read commit ; do \
     echo "commit $commit" ; \
     git log --format=email --stat -p -1 $commit | \
     ./scripts/checkpatch.pl --codespell - ; \
   done | \
   tee spell_v7.0.0..v8.2.0-rc2.txt | \
   grep "may be misspelled" | awk '{print $2}' | \
   tr A-Z a-z | sort | uniq -c | sort -rn

The typos were listed as follows (In addition to variable naming and
misreporting, select typos greater than three times):

   1289 'fpr'
    222 'ot'
     45 'hace'
     25 'te'
     24 'parm'
     21 'sie'
     20 'nd'
     20 'clen'
     15 'sring'
     14 'hax'
     13 'hda'
     12 'endianess'
     10 'tabl'
     10 'stip'
     10 'datas'
      9 'reenable'
      8 'unitialized'
      8 'invers'
      7 'seh'
      7 'priviledge'
      7 'indentification'
      7 'existance'
      6 'varience'
      6 'unuseful'
      6 'tranfer'
      6 'tne'
      6 'octects'
      6 'informations'
      6 'indicies'
      6 'extenstion'
      6 'betwen'
      6 'ammends'
      5 'writting'
      5 'wont'
      5 'som'
      5 'responsability'
      5 'padd'
      5 'offsetp'
      5 'negotation'
      5 'necesary'
      5 'nam'
      5 'maintainance'
      5 'extnesion'
      5 'convertion'
      5 'configuraiton'
      5 'comparision'
      5 'arbitrer'
      5 'an
      5 'algorithim'
      5 'addreses'
      5 'achived'
      5 'accomodate'
      4 'undocummented'
      4 'ue'
      4 'truely'
      4 'tre'
      4 'suppoted'
      4 'separatly'
      4 'reenabled'
      4 'occured'
      4 'myu'
      4 'mone'
      4 'ment'
      4 'limitaions'
      4 'instread'
      4 'infomation'
      4 'implment'
      4 'hammmer'
      4 'desciptor'
      4 'defintions'
      4 'crypted'
      4 'constext'
      4 'acces'
      3 'wronly'
      3 'wether'
      3 'vill'
      3 'unsupport'
      3 'unneded'
      3 'transfered'
      3 'sxl'
      3 'suppor'
      3 'superceded'
      3 'succesfully'
      3 'slighly'
      3 'setted'
      3 'respectivelly'
      3 'reigster'
      3 'recive'
      3 'priviledged'
      3 'potentialy'
      3 'phyiscal'
      3 'pathes'
      3 'othe'
      3 'ontaining'
      3 'nunber'
      3 'missmatch'
      3 'minumum'
      3 'mesage'
      3 'legnth'
      3 'kenel'
      3 'intialized'
      3 'inbetween'
      3 'implemetation'
      3 'garanteed'
      3 'explictly'
      3 'enhacements'
      3 'ealier'
      3 'doen't'
      3 'diferent'
      3 'debuging'
      3 'daa'
      3 'convergance'
      3 'compatiblity'
      3 'caf'
      3 'buid'
      3 'becase'
      3 'bandwith'
      3 'atleast'
      3 'asume'
      3 'analoguous'
      3 'alse'
      3 'addtionally'
      3 'addtional'
      3 'addresss'
      3 'acknowledgement'
      3 'accross'
      3 'acceses'

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 scripts/spelling.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 549ffd0f2d78..177dee2bb28d 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -28,6 +28,7 @@ accelaration||acceleration
 accelearion||acceleration
 acceleratoin||acceleration
 accelleration||acceleration
+acces||access
 accesing||accessing
 accesnt||accent
 accessable||accessible
@@ -50,6 +51,7 @@ acessable||accessible
 acess||access
 acessing||accessing
 achitecture||architecture
+achived||achieved
 acient||ancient
 acitions||actions
 acitve||active
@@ -95,6 +97,7 @@ albumns||albums
 alegorical||allegorical
 algined||aligned
 algorith||algorithm
+algorithim||algorithm
 algorithmical||algorithmically
 algoritm||algorithm
 algoritms||algorithms
@@ -124,6 +127,7 @@ altough||although
 alue||value
 ambigious||ambiguous
 ambigous||ambiguous
+ammend||amend
 amoung||among
 amount of times||number of times
 amout||amount
@@ -248,6 +252,7 @@ beeing||being
 befor||before
 begining||beginning
 beter||better
+betwen||between
 betweeen||between
 bianries||binaries
 bitmast||bitmask
@@ -350,6 +355,7 @@ comsuming||consuming
 comaptible||compatible
 compability||compatibility
 compaibility||compatibility
+comparision||comparison
 comparsion||comparison
 compatability||compatibility
 compatable||compatible
@@ -385,6 +391,7 @@ configred||configured
 configuartion||configuration
 configuation||configuration
 configued||configured
+configuraiton||configuration
 configuratoin||configuration
 configuraton||configuration
 configuretion||configuration
@@ -658,6 +665,7 @@ exteneded||extended
 extensability||extensibility
 extention||extension
 extenstion||extension
+extnesion||extension
 extracter||extractor
 faied||failed
 faield||failed
@@ -796,6 +804,7 @@ implementd||implemented
 implemetation||implementation
 implemntation||implementation
 implentation||implementation
+implment||implement
 implmentation||implementation
 implmenting||implementing
 incative||inactive
@@ -812,11 +821,13 @@ incuding||including
 inculde||include
 indendation||indentation
 indended||intended
+indentification||identification
 independant||independent
 independantly||independently
 independed||independent
 indiate||indicate
 indicat||indicate
+indicies||indices
 inexpect||inexpected
 inferface||interface
 infinit||infinite
@@ -850,6 +861,7 @@ instace||instance
 instal||install
 instanciate||instantiate
 instanciated||instantiated
+instread||instead
 instuments||instruments
 insufficent||insufficient
 inteface||interface
@@ -934,6 +946,7 @@ libary||library
 librairies||libraries
 libraris||libraries
 licenceing||licencing
+limitaion||limitation
 limted||limited
 logaritmic||logarithmic
 loggging||logging
@@ -1331,6 +1344,7 @@ resouce||resource
 resouces||resources
 resoures||resources
 responce||response
+responsability||responsibility
 resrouce||resource
 ressizes||resizes
 ressource||resource
@@ -1554,6 +1568,7 @@ throught||through
 tansition||transition
 trackling||tracking
 troughput||throughput
+truely||truly
 trys||tries
 thses||these
 tiggers||triggers
@@ -1623,6 +1638,7 @@ unknouwn||unknown
 unknow||unknown
 unkown||unknown
 unamed||unnamed
+undocummented||undocumented
 uneeded||unneeded
 unneded||unneeded
 unneccecary||unnecessary
-- 
2.34.1


